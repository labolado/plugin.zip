##
## Auto Generated makefile by CodeLite IDE
## any manual changes will be erased      
##
## Release
ProjectName            :=zip
ConfigurationName      :=Release
IntermediateDirectory  :=./Release
OutDir                 := $(IntermediateDirectory)
CurrentFileName        :=
CurrentFilePath        :=
CurrentFileFullPath    :=
User                   :=ubuntu
Date                   :=26/04/22
LinkerName             :=/usr/bin/g++
SharedObjectLinkerName :=/usr/bin/g++ -shared -fPIC
ObjectSuffix           :=.o
DependSuffix           :=.o.d
PreprocessSuffix       :=.i
DebugSwitch            :=-g 
IncludeSwitch          :=-I
LibrarySwitch          :=-l
OutputSwitch           :=-o 
LibraryPathSwitch      :=-L
PreprocessorSwitch     :=-D
SourceSwitch           :=-c 
OutputFile             :=$(IntermediateDirectory)/plugin.$(ProjectName).so
Preprocessors          :=$(PreprocessorSwitch)NDEBUG 
ObjectSwitch           :=-o 
ArchiveOutputSwitch    := 
PreprocessOnlySwitch   :=-E
ObjectsFileList        :="zip.txt"
PCHCompileFlags        :=
MakeDirCommand         :=mkdir -p
LinkOptions            :=  
IncludePath            :=  $(IncludeSwitch). $(IncludeSwitch). $(IncludeSwitch)../shared $(IncludeSwitch)../shared/CoronaEnterprise/shared/include $(IncludeSwitch)../shared/minizip 
IncludePCH             := 
RcIncludePath          := 
Libs                   := 
ArLibs                 :=  
LibPath                := $(LibraryPathSwitch). 

##
## Common variables
## AR, CXX, CC, AS, CXXFLAGS and CFLAGS can be overriden using an environment variables
##
AR       := /usr/bin/ar rcu
CXX      := /usr/bin/g++
CC       := /usr/bin/gcc
CXXFLAGS :=  -O2 -Wall -fPIC $(Preprocessors)
CFLAGS   :=  -O2 -Wall -fPIC $(Preprocessors)
ASFLAGS  := 
AS       := /usr/bin/as


##
## User defined environment variables
##
CodeLiteDir:=/usr/share/codelite
Objects0=$(IntermediateDirectory)/up_shared_AsyncZip.cpp$(ObjectSuffix) $(IntermediateDirectory)/up_shared_ZipLibrary.cpp$(ObjectSuffix) $(IntermediateDirectory)/up_shared_ZipTask.cpp$(ObjectSuffix) $(IntermediateDirectory)/up_shared_minizip_ioapi.c$(ObjectSuffix) $(IntermediateDirectory)/up_shared_ZipEvent.cpp$(ObjectSuffix) $(IntermediateDirectory)/up_shared_minizip_unzip.c$(ObjectSuffix) $(IntermediateDirectory)/up_shared_minizip_mztools.c$(ObjectSuffix) $(IntermediateDirectory)/up_shared_minizip_zip.c$(ObjectSuffix) 



Objects=$(Objects0) 

##
## Main Build Targets 
##
.PHONY: all clean PreBuild PrePreBuild PostBuild MakeIntermediateDirs
all: $(OutputFile)

$(OutputFile): $(IntermediateDirectory)/.d $(Objects) 
	@$(MakeDirCommand) $(@D)
	@echo "" > $(IntermediateDirectory)/.d
	@echo $(Objects0)  > $(ObjectsFileList)
	$(SharedObjectLinkerName) $(OutputSwitch)$(OutputFile) @$(ObjectsFileList) $(LibPath) $(Libs) $(LinkOptions)
	@$(MakeDirCommand) "$(HOME)/Documents/plugins/.build-release"
	@echo rebuilt > "$(HOME)/Documents/plugins/.build-release/zip"

MakeIntermediateDirs:
	@test -d ./Release || $(MakeDirCommand) ./Release


$(IntermediateDirectory)/.d:
	@test -d ./Release || $(MakeDirCommand) ./Release

PreBuild:


##
## Objects
##
$(IntermediateDirectory)/up_shared_AsyncZip.cpp$(ObjectSuffix): ../shared/AsyncZip.cpp $(IntermediateDirectory)/up_shared_AsyncZip.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "../shared/AsyncZip.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/up_shared_AsyncZip.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/up_shared_AsyncZip.cpp$(DependSuffix): ../shared/AsyncZip.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/up_shared_AsyncZip.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/up_shared_AsyncZip.cpp$(DependSuffix) -MM ../shared/AsyncZip.cpp

$(IntermediateDirectory)/up_shared_AsyncZip.cpp$(PreprocessSuffix): ../shared/AsyncZip.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/up_shared_AsyncZip.cpp$(PreprocessSuffix) ../shared/AsyncZip.cpp

$(IntermediateDirectory)/up_shared_ZipLibrary.cpp$(ObjectSuffix): ../shared/ZipLibrary.cpp $(IntermediateDirectory)/up_shared_ZipLibrary.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "../shared/ZipLibrary.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/up_shared_ZipLibrary.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/up_shared_ZipLibrary.cpp$(DependSuffix): ../shared/ZipLibrary.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/up_shared_ZipLibrary.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/up_shared_ZipLibrary.cpp$(DependSuffix) -MM ../shared/ZipLibrary.cpp

$(IntermediateDirectory)/up_shared_ZipLibrary.cpp$(PreprocessSuffix): ../shared/ZipLibrary.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/up_shared_ZipLibrary.cpp$(PreprocessSuffix) ../shared/ZipLibrary.cpp

$(IntermediateDirectory)/up_shared_ZipTask.cpp$(ObjectSuffix): ../shared/ZipTask.cpp $(IntermediateDirectory)/up_shared_ZipTask.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "../shared/ZipTask.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/up_shared_ZipTask.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/up_shared_ZipTask.cpp$(DependSuffix): ../shared/ZipTask.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/up_shared_ZipTask.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/up_shared_ZipTask.cpp$(DependSuffix) -MM ../shared/ZipTask.cpp

$(IntermediateDirectory)/up_shared_ZipTask.cpp$(PreprocessSuffix): ../shared/ZipTask.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/up_shared_ZipTask.cpp$(PreprocessSuffix) ../shared/ZipTask.cpp

$(IntermediateDirectory)/up_shared_minizip_ioapi.c$(ObjectSuffix): ../shared/minizip/ioapi.c $(IntermediateDirectory)/up_shared_minizip_ioapi.c$(DependSuffix)
	$(CC) $(SourceSwitch) "../shared/minizip/ioapi.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/up_shared_minizip_ioapi.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/up_shared_minizip_ioapi.c$(DependSuffix): ../shared/minizip/ioapi.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/up_shared_minizip_ioapi.c$(ObjectSuffix) -MF$(IntermediateDirectory)/up_shared_minizip_ioapi.c$(DependSuffix) -MM ../shared/minizip/ioapi.c

$(IntermediateDirectory)/up_shared_minizip_ioapi.c$(PreprocessSuffix): ../shared/minizip/ioapi.c
	$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/up_shared_minizip_ioapi.c$(PreprocessSuffix) ../shared/minizip/ioapi.c

$(IntermediateDirectory)/up_shared_ZipEvent.cpp$(ObjectSuffix): ../shared/ZipEvent.cpp $(IntermediateDirectory)/up_shared_ZipEvent.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "../shared/ZipEvent.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/up_shared_ZipEvent.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/up_shared_ZipEvent.cpp$(DependSuffix): ../shared/ZipEvent.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/up_shared_ZipEvent.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/up_shared_ZipEvent.cpp$(DependSuffix) -MM ../shared/ZipEvent.cpp

$(IntermediateDirectory)/up_shared_ZipEvent.cpp$(PreprocessSuffix): ../shared/ZipEvent.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/up_shared_ZipEvent.cpp$(PreprocessSuffix) ../shared/ZipEvent.cpp

$(IntermediateDirectory)/up_shared_minizip_unzip.c$(ObjectSuffix): ../shared/minizip/unzip.c $(IntermediateDirectory)/up_shared_minizip_unzip.c$(DependSuffix)
	$(CC) $(SourceSwitch) "../shared/minizip/unzip.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/up_shared_minizip_unzip.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/up_shared_minizip_unzip.c$(DependSuffix): ../shared/minizip/unzip.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/up_shared_minizip_unzip.c$(ObjectSuffix) -MF$(IntermediateDirectory)/up_shared_minizip_unzip.c$(DependSuffix) -MM ../shared/minizip/unzip.c

$(IntermediateDirectory)/up_shared_minizip_unzip.c$(PreprocessSuffix): ../shared/minizip/unzip.c
	$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/up_shared_minizip_unzip.c$(PreprocessSuffix) ../shared/minizip/unzip.c

$(IntermediateDirectory)/up_shared_minizip_mztools.c$(ObjectSuffix): ../shared/minizip/mztools.c $(IntermediateDirectory)/up_shared_minizip_mztools.c$(DependSuffix)
	$(CC) $(SourceSwitch) "../shared/minizip/mztools.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/up_shared_minizip_mztools.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/up_shared_minizip_mztools.c$(DependSuffix): ../shared/minizip/mztools.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/up_shared_minizip_mztools.c$(ObjectSuffix) -MF$(IntermediateDirectory)/up_shared_minizip_mztools.c$(DependSuffix) -MM ../shared/minizip/mztools.c

$(IntermediateDirectory)/up_shared_minizip_mztools.c$(PreprocessSuffix): ../shared/minizip/mztools.c
	$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/up_shared_minizip_mztools.c$(PreprocessSuffix) ../shared/minizip/mztools.c

$(IntermediateDirectory)/up_shared_minizip_zip.c$(ObjectSuffix): ../shared/minizip/zip.c $(IntermediateDirectory)/up_shared_minizip_zip.c$(DependSuffix)
	$(CC) $(SourceSwitch) "../shared/minizip/zip.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/up_shared_minizip_zip.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/up_shared_minizip_zip.c$(DependSuffix): ../shared/minizip/zip.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/up_shared_minizip_zip.c$(ObjectSuffix) -MF$(IntermediateDirectory)/up_shared_minizip_zip.c$(DependSuffix) -MM ../shared/minizip/zip.c

$(IntermediateDirectory)/up_shared_minizip_zip.c$(PreprocessSuffix): ../shared/minizip/zip.c
	$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/up_shared_minizip_zip.c$(PreprocessSuffix) ../shared/minizip/zip.c


-include $(IntermediateDirectory)/*$(DependSuffix)
##
## Clean
##
clean:
	$(RM) -r ./Release/


