//
//  AsyncZip.cpp
//  Plugin
//
//  Created by CoronaLabs on 4/18/13.
//
//

#include "AsyncZip.h"
#include "LuaReader.h"

namespace Corona
{

	static pthread_mutex_t queueLock = PTHREAD_MUTEX_INITIALIZER;

	AsyncZip::AsyncZip(lua_State *L )
	: _L( L )
	{
		pthread_mutex_init(&queueLock, NULL);
		fFrameCounter = 0;
		
		asyncTask.Start();
	}
	AsyncZip::~AsyncZip()
	{
		
		pthread_mutex_destroy(&queueLock);
	}
	bool AsyncZip::Initialize( char *appId )
	{
		return true;
	}
	void AsyncZip::Finalize( lua_State *L )
	{
	
		//Block/wait, tasks finishing will post their result
		//to TaskFinished within this call
		asyncTask.End();
	
		//If the last thread just posted something to the queue
		pthread_mutex_lock(&queueLock);
		
		for (int i = 0; i < fFinishedTasks.size(); i++)
		{
			ZipTask *zipCmd = static_cast<ZipTask*>(fFinishedTasks.front());
			zipCmd->Finalize(L);
			delete zipCmd;
			fFinishedTasks.pop();
		}
		
		_L = NULL;
				
		pthread_mutex_unlock(&queueLock);
	}
	void AsyncZip::TaskFinished(void *data)
	{
		
		pthread_mutex_lock(&queueLock);
		fFinishedTasks.push(static_cast<ZipTask*>(data));
		pthread_mutex_unlock(&queueLock);
		
	}
	
	//Only dispatch events from the main queue!
	void AsyncZip::ProcessFrame(lua_State *L)
	{
		//Only process this every 15 frames
		fFrameCounter++;
		if (fFrameCounter >= 50)
		{
			pthread_mutex_lock(&queueLock);
			if (fFinishedTasks.size() > 0)
			{
				ZipTask *zipCmd = static_cast<ZipTask*>(fFinishedTasks.front());
				
				if (_L != NULL)
				{
					zipCmd->DoDispatch(L);
					zipCmd->Finalize(L);
				}
				delete zipCmd;
				
				fFinishedTasks.pop();
			}
			pthread_mutex_unlock(&queueLock);
			
			fFrameCounter = 0;
		}
	}
	void AsyncZip::Uncompress( lua_State *L )
	{
		
		if (lua_istable( L, -1 ) == false)
		{
			CoronaLog("Uncompress Error: Missing input options\n");
			return;
		}

		LMap paramsMap		= LuaReader::GetDataMap(L,1);
		
		
		LDataListener *listener = static_cast<LDataListener*>(paramsMap.GetData("listener"));
		
		if (listener == NULL)
		{
			CoronaLog("Uncompress Error: Missing listener parameter\n");
			return;
		}
		
		CoronaLuaRef coronaListener = listener->GetListener();
		
		LDataString *archive = static_cast<LDataString*>(paramsMap.GetData("zipFile"));
		
		if (archive == NULL)
		{
			ZipEvent e(ZipEvent::kUnZipType, "Missing zipFile parameter", true);
			e.Push(L);
			e.Dispatch(L, coronaListener);
			return;
		}
		
		LDataBool *flattenOutput = static_cast<LDataBool*>(paramsMap.GetData("flattenOutput"));
		
		bool bFlattenOutput = false;
		if (flattenOutput != NULL)
		{
			bFlattenOutput = flattenOutput->GetBool();
		}
		
		LDataLUD *srcPath = static_cast<LDataLUD*>(paramsMap.GetData("zipBaseDir"));
		
		if (srcPath == NULL)
		{
			ZipEvent e(ZipEvent::kUnZipType, "Missing zipBaseDir parameter", true);
			e.Push(L);
			e.Dispatch(L, coronaListener);
			return;
		}
		
		std::string fileName = archive->GetStr();
		const char *path = LuaReader::GetPathForFileBaseDir(L, srcPath->GetData(),fileName.c_str());
		
		if (path == NULL)
		{
			ZipEvent e(ZipEvent::kUnZipType, "Path to Zip file is invalid", true);
			e.Push(L);
			e.Dispatch(L, coronaListener);
			return;
		}
		
		LDataLUD *dstPath = static_cast<LDataLUD*>(paramsMap.GetData("dstBaseDir"));
		
		if (dstPath == NULL)
		{
			ZipEvent e(ZipEvent::kUnZipType, "Missing dstBaseDir parameter", true);
			e.Push(L);
			e.Dispatch(L, coronaListener);
			return;
		}
		
		LMap *fileNames = NULL;
		
		//Optional parameter
		LMap *files = static_cast<LMap*>(paramsMap.GetData("files"));
		if (files != NULL)
		{
			fileNames = static_cast<LMap*>(files->GetCopy());
		}
		
		std::string pathSource	= path;
		
		std::string outputDir	= LuaReader::GetPathForFileBaseDir(L, dstPath->GetData(),NULL);
		
		LDataString *pass = static_cast<LDataString*>(paramsMap.GetData("password"));
		std::string *password = NULL;
		if (pass != NULL)
		{
			password = new std::string(pass->GetStr());
		}
		
		ZipTaskExtract *zipTask = new ZipTaskExtract(	pathSource,
														outputDir,
														password,
														fileNames,
														bFlattenOutput,
														coronaListener);
		
		AsyncTaskWithProxy *taskWithProxy = new AsyncTaskWithProxy(zipTask,this);
		
		asyncTask.AddTask(taskWithProxy);
		
	}
	void AsyncZip::List( lua_State *L )
	{
		if (lua_istable( L, -1 ) == false)
		{
			CoronaLog("List Error: Missing input options\n");
			return;
		}
		
		LMap paramsMap		= LuaReader::GetDataMap(L,1);
		
		LDataListener *listener = static_cast<LDataListener*>(paramsMap.GetData("listener"));
		
		if (listener == NULL)
		{
			CoronaLog("List Error: Missing listener parameter\n");
			return;
		}
		
		CoronaLuaRef coronaListener = listener->GetListener();
		
		LDataString *archive = static_cast<LDataString*>(paramsMap.GetData("zipFile"));
		
		if (archive == NULL)
		{
			ZipEvent e(ZipEvent::kFileType, "Missing zipFile parameter", true);
			e.Push(L);
			e.Dispatch(L, coronaListener);
			return;
		}
		
		LDataLUD *srcPath = static_cast<LDataLUD*>(paramsMap.GetData("zipBaseDir"));
		
		if (srcPath == NULL)
		{
			ZipEvent e(ZipEvent::kFileType, "Missing zipBaseDir parameter", true);
			e.Push(L);
			e.Dispatch(L, coronaListener);
			return;
		}
		
		std::string fileName = archive->GetStr();
		const char *path = LuaReader::GetPathForFileBaseDir(L, srcPath->GetData(),fileName.c_str());
		
		if (path == NULL)
		{
			ZipEvent e(ZipEvent::kFileType, "Path to Zip file is invalid", true);
			e.Push(L);
			e.Dispatch(L, coronaListener);
			return;
		}


		std::string pathSource	= path;
		
		ZipTaskListAllFilesInZip *zipTask = new ZipTaskListAllFilesInZip(	pathSource,
																		 coronaListener);
		
		AsyncTaskWithProxy *taskWithProxy = new AsyncTaskWithProxy(zipTask,this);
		
		asyncTask.AddTask(taskWithProxy);
		
	}
	void AsyncZip::Compress( lua_State *L )
	{
		
		if (lua_istable( L, -1 ) == false)
		{
			CoronaLog("Compress Error: Missing input options\n");
			return;
		}
		
		LMap paramsMap		= LuaReader::GetDataMap(L,1);
		
		LDataListener *listener = static_cast<LDataListener*>(paramsMap.GetData("listener"));
		
		if (listener == NULL)
		{
			CoronaLog("Compress Error: Missing listener parameter\n");
			return;
		}
		
		CoronaLuaRef coronaListener = listener->GetListener();
		
		LDataString *archive = static_cast<LDataString*>(paramsMap.GetData("zipFile"));
		
		if (archive == NULL)
		{
			ZipEvent e(ZipEvent::kZipType, "Missing zipFile parameter", true);
			e.Push(L);
			e.Dispatch(L, coronaListener);
			return;
		}
		
		LDataLUD *srcFilesPath = static_cast<LDataLUD*>(paramsMap.GetData("srcBaseDir"));
		
		if (srcFilesPath == NULL)
		{
			ZipEvent e(ZipEvent::kZipType, "Missing srcBaseDir parameter", true);
			e.Push(L);
			e.Dispatch(L, coronaListener);
			return;
		}
		
		LDataLUD *srcPath = static_cast<LDataLUD*>(paramsMap.GetData("zipBaseDir"));
		
		if (srcPath == NULL)
		{
			ZipEvent e(ZipEvent::kZipType, "Missing zipBaseDir parameter", true);
			e.Push(L);
			e.Dispatch(L, coronaListener);
			return;
		}
		
		std::string fileName = archive->GetStr();
		std::string archivePath	= LuaReader::GetPathForFileBaseDir(L,srcPath->GetData(),fileName.c_str());
		
		LVector fileList, rawFileList;
		LMap *fileNames	= static_cast<LMap*>(paramsMap.GetData("srcFiles"));
		
		if (fileNames != NULL)
		{
			LDataBool *includeFilePath = static_cast<LDataBool*>(paramsMap.GetData("includeFilePath"));
			bool bIncludeFilePath = false;
			if (includeFilePath != NULL)
			{
				bIncludeFilePath = includeFilePath->GetBool();
			}
			std::vector<std::string> keys = fileNames->GetKeys();
			for (int i = 0; i < keys.size(); i++)
			{
				LDataString *curFile = static_cast<LDataString*>(fileNames->GetData(keys[i]));

				const char *path =  LuaReader::GetPathForFileBaseDir(L,srcFilesPath->GetData(),curFile->GetStr().c_str());
				if (path != NULL)
				{
					std::string fullPath = path;
					fileList.Push(fullPath);
					if (bIncludeFilePath)
					{
						rawFileList.Push(curFile->GetStr().c_str());
					}
				}
				else
				{
					ZipEvent e(ZipEvent::kZipType, "Missing one or more source files", true);
					e.Push(L);
					e.Dispatch(L, coronaListener);
					return;
				}
			}
		}
		else
		{
			ZipEvent e(ZipEvent::kZipType, "Missing srcFiles parameter", true);
			e.Push(L);
			e.Dispatch(L, coronaListener);
			return;
		}
		
		LDataString *pass = static_cast<LDataString*>(paramsMap.GetData("password"));
		std::string *password = NULL;
		if (pass != NULL)
		{
			password = new std::string(pass->GetStr());
		}
		
		ZipTaskAddFileToZip *zipTask = new ZipTaskAddFileToZip( archivePath,
															   password,
															   fileList, rawFileList,
															   coronaListener);
		
		AsyncTaskWithProxy *taskWithProxy = new AsyncTaskWithProxy(zipTask,this);
		
		asyncTask.AddTask(taskWithProxy);
		
	}
	
	void
	AsyncZip::Dispatch( const ZipEvent& e,  CoronaLuaRef lRef) const
	{
		e.Dispatch( _L, lRef);
	}
	
	// -----
	
} // namespace Corona

