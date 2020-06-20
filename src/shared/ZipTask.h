//
//  TestTask.h
//  Plugin
//
//  Created by CoronaLabs on 4/29/13.
//
//

#ifndef __Plugin__TestTask__
#define __Plugin__TestTask__

#include <iostream>
#include "CommandInterface.h"
#include "DispatchInterface.h"
#include "LuaMap.h"

#include "ZipEvent.h"

namespace Corona
{
	class ZipTask : public CommandInterface, public DispatchInterface
	{
		
	public:
		ZipTask():
		fIsError(false)
		{
		}
		virtual ~ZipTask()
		{
		};
		void Finalize(lua_State *L)
		{
			CoronaLuaDeleteRef(L,fRef);
		}
		
	protected:
		bool fIsError;
		CoronaLuaRef fRef;
		
	};
	
	class ZipTaskExtract : public ZipTask
	{
		
	public:
		// We use string pointer for password because empty string is a valid password
		ZipTaskExtract(	std::string pathSource,
					   std::string outputDir,
					   std::string *password,
					   LMap *fileNames,
					   bool flattenOutput,
					   CoronaLuaRef ref);
		virtual ~ZipTaskExtract();
		virtual void Execute(CommandInterface *data);
		virtual void DoDispatch(lua_State *L);
		
		
	private:
		std::string fPathSource;
		std::string fOutputDir;
		std::string *fPassword;
		LMap *fFileNames;
		bool fFlattenOutput;
		
		//Output
		LuaMapData fOutputList;
		
	};
	
	struct output_info
	{
		std::string fileName;
		unsigned long long size;
		unsigned long crc;
		unsigned long ratio;
	};
	
	class ZipTaskListAllFilesInZip : public ZipTask
	{
		
	public:
		ZipTaskListAllFilesInZip(	std::string pathSource,
								 CoronaLuaRef ref);
		virtual ~ZipTaskListAllFilesInZip();
		
		
		virtual void Execute(CommandInterface *data);
		virtual void DoDispatch(lua_State *L);
		
		
	private:
		std::string fPathSource;
		
		//Output
		std::vector<output_info> fOutputInfo;

	};
	
	class ZipTaskAddFileToZip : public ZipTask
	{
		
	public:
		// We use string pointer for password because empty string is a valid password
		ZipTaskAddFileToZip(std::string pathSource,
							std::string *password,
							LVector fileList,
							CoronaLuaRef ref);
		virtual ~ZipTaskAddFileToZip();
		
		
		virtual void Execute(CommandInterface *data);
		virtual void DoDispatch(lua_State *L);
		
		
	private:
		std::string fPathSource;
		std::string *fPassword;
		LVector fFileList;
		
		//Output
		std::vector<output_info> fOutputInfo;
		
	};
	
}
#endif /* defined(__Plugin__TestTask__) */
