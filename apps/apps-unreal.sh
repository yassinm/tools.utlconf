UTLAPPS_unreal_init(){
  alias ue-vscode="UTLDEV_unreal_vscode"
  alias ue-scripts="UTLAPPS_unreal_scripts"
  alias ue-build="UTLDEV_unreal_buildproject"
}

UTLAPPS_unreal_env(){
    UNREAL_ROOT="${UTL3RDP_GITHUB}/unreal/UnrealEngine"
}

UTLAPPS_unreal_scripts(){
    UTLAPPS_unreal_env

    local lVersion=""

    for lVersion in 4.12 4.13 ; do {
        UTLDEV_unreal_buildfile ${lVersion}
    } done

}

UTLDEV_unreal_setup(){
    https://wiki.unrealengine.com/Building_On_Linux

    build-essential mono-gmcs mono-xbuild mono-dmcs libmono-corlib4.0-cil libmono-system-data-datasetextensions4.0-cil
    libmono-system-web-extensions4.0-cil libmono-system-management4.0-cil libmono-system-xml-linq4.0-cil cmake dos2unix clang xdg-user-dirs

    apt-get install -y build-essential mono-gmcs mono-xbuild mono-dmcs libmono-corlib4.0-cil libmono-system-data-datasetextensions4.0-cil \
    libmono-system-web-extensions4.0-cil libmono-system-management4.0-cil libmono-system-xml-linq4.0-cil cmake dos2unix clang-3.5 libfreetype6-dev libgtk-3-dev libmono-microsoft-build-tasks-v4.0-4.0-cil xdg-user-dirs

    git clone -b 4.12 https://github.com/EpicGames/UnrealEngine.git unreal.4.12
    cd unreal.4.12
    ./Setup.sh
    ./GenerateProjectFiles.sh && make


}

UTLDEV_unreal_install(){
    # assume the latest Ubuntu, this is going to be a moving target
     DEPS="mono-xbuild \
       mono-dmcs \
       libmono-microsoft-build-tasks-v4.0-4.0-cil \
       libmono-system-data-datasetextensions4.0-cil
       libmono-system-web-extensions4.0-cil
       libmono-system-management4.0-cil
       libmono-system-xml-linq4.0-cil
       libmono-corlib4.5-cil
       libmono-windowsbase4.0-cil
       libmono-system-io-compression4.0-cil
       libmono-system-io-compression-filesystem4.0-cil
       libmono-system-runtime4.0-cil
       mono-devel
       clang-3.9
       build-essential
       "

    for DEP in $DEPS; do
        echo "Attempting installation of missing package: $DEP"
        (
            set -ex
            sudo apt-get install -y $DEP
        )
    done

}

UTLDEV_unreal_buildproject(){
    UTLAPPS_unreal_env

    set -x

    local projectName="${1}"
    if [ -z "${projectName}" ] ; then
        echo must pass project name; return
    fi

    local projectDir=`pwd`;
    local randomNumber=$( date "+%s");
    # local randomNumber=$(( ( RANDOM % 1000 ) + 1000 )); #echo $randomNumber
    # projectName=$(basename ${projectName%.uproject});
    echo building "${projectDir}/${projectName}.uproject"
    ${UNREAL_ROOT}/Engine/Build/BatchFiles/Linux/RunMono.sh ${UNREAL_ROOT}/Engine/Binaries/DotNET/UnrealBuildTool.exe $projectName -ModuleWithSuffix $projectName $randomNumber Linux Development -editorrecompile -canskiplink "${projectDir}/${projectName}.uproject" -progress


    set +x
}

UTLDEV_unreal_buildfile(){
    mkdir -p ${UNREAL_ROOT}/sbin

    local lVersion="${1}"
    local buildFile="${UNREAL_ROOT}/sbin/build-${lVersion}.sh"

cat <<E_O_F> ${buildFile}
#!/bin/bash

set -e

uebuild(){
    local lDir="${UNREAL_ROOT}/unreal.${lVersion}"

    if [ -e "\${lDir}" ] ; then
        cd \${lDir} && echo git pull
    else
        cd ${UNREAL_ROOT}
        git clone -b ${lVersion} https://github.com/EpicGames/UnrealEngine.git unreal.${lVersion}
    fi

    cd \${lDir} && ./Setup.sh && ./GenerateProjectFiles.sh && make

}

uebuild "\${@}"

E_O_F

    chmod 744 ${buildFile}
}

UTLDEV_unreal_vscode(){
  UTLAPPS_unreal_env
  local vscodeProps="./.vscode/launch.json"
  local vscodeCppProps="./.vscode/c_cpp_properties.json"
  local ueLoc="${UNREAL_ROOT}/Engine/Binaries/Linux/UE4Editor"

cat <<E_O_F> ${vscodeCppProps}
  {
      "configurations": [
          {
              "name": "Mac",
              "includePath": ["/usr/include"],
              "browse" : {
                  "limitSymbolsToIncludedHeaders" : true,
                  "databaseFilename" : ""
              }
          },
          {
              "name": "Linux",
              "includePath": ["/usr/include"
                , "${UNREAL_ROOT}/Engine/Source/Runtime/Engine/Classes"
                , "${UNREAL_ROOT}/Engine/Source/Runtime/InputCore/Classes"

                ,"${UNREAL_ROOT}/Engine/Source/Runtime/GameplayTasks/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/RuntimeAssetCache/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/IOS/IOSLocalNotification/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/IOS/IOSAudio/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/IOS/LaunchDaemonMessages/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Projects/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Serialization/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/PhysXFormats/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Slate/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/SessionMessages/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/IPC/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/UMG/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/ShaderCore/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/HTML5/HTML5JS/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/HTML5/Simulator/HTML5Win32/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/HTML5/MapPakDownloader/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/NullDrv/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/NetworkReplayStreaming/NetworkReplayStreaming/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/NetworkReplayStreaming/NullNetworkReplayStreaming/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/NetworkReplayStreaming/HttpNetworkReplayStreaming/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/NetworkReplayStreaming/InMemoryNetworkReplayStreaming/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/DatabaseSupport/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Messaging/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/MovieScene/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/GameMenuBuilder/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Media/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/AnimGraphRuntime/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/StreamingFile/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/AssetRegistry/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/MovieSceneTracks/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/GameLiveStreaming/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/MessagingRpc/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/MovieSceneCapture/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Foliage/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Advertising/IOS/IOSAdvertising/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Advertising/Advertising/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Advertising/Android/AndroidAdvertising/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/PakFile/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/ImageWrapper/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/FriendsAndChat/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Landscape/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Apple/MetalRHI/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Networking/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Analytics/AnalyticsSwrve/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Analytics/Analytics/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Analytics/AnalyticsVisualEditing/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Analytics/AnalyticsET/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Analytics/QoSReporter/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/VectorVM/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/CinematicCamera/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/GameplayAbilities/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/EngineSettings/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Sockets/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/InputDevice/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/SessionServices/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/SlateNullRenderer/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Windows/D3D11RHI/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Windows/XAudio2/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/SlateCore/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Launch/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/AIModule/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/AppFramework/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/UnrealAudio/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Niagara/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Online/ImageDownload/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Online/WebSockets/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Online/Stomp/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Online/Voice/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Online/BuildPatchServices/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Online/ICMP/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Online/SSL/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Online/HTTP/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Online/XMPP/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/MoviePlayer/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/XmlParser/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/SandboxFile/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/ALAudio/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/HardwareSurvey/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/LevelSequence/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Internationalization/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/NetworkFile/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/EngineMessages/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/SynthBenchmark/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/HeadMountedDisplay/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Portal/LauncherCheck/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Portal/Messages/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Portal/Services/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Portal/Rpc/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/RHI/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/MediaAssets/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Navmesh/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/ImageCore/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Mac/CoreAudio/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/PacketHandlers/ReliabilityHandlerComponent/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/PacketHandlers/PacketHandler/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/PacketHandlers/EncryptionComponents/SymmetricEncryption/BlockEncryption/XORBlockEncryptor/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/PacketHandlers/EncryptionComponents/SymmetricEncryption/BlockEncryption/BlockEncryptionHandlerComponent/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/PacketHandlers/EncryptionComponents/SymmetricEncryption/BlockEncryption/TwoFishBlockEncryptor/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/PacketHandlers/EncryptionComponents/SymmetricEncryption/BlockEncryption/AESBlockEncryptor/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/PacketHandlers/EncryptionComponents/SymmetricEncryption/BlockEncryption/BlowFishBlockEncryptor/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/PacketHandlers/EncryptionComponents/SymmetricEncryption/StreamEncryption/XORStreamEncryptor/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/PacketHandlers/EncryptionComponents/SymmetricEncryption/StreamEncryption/StreamEncryptionHandlerComponent/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/PacketHandlers/EncryptionComponents/AsymmetricEncryption/RSAEncryptionHandlerComponent/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/PacketHandlers/EncryptionComponents/EncryptionHandlerComponent/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/WebBrowser/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/OpenGLDrv/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/SQLiteSupport/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/PerfCounters/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/SlateRHIRenderer/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/D3D12RHI/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/CoreUObject/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/CEF3Utils/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/BlueprintRuntime/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Renderer/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Toolbox/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/VulkanRHI/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/GeometryCache/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/EmptyRHI/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/WidgetCarousel/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/GameplayTags/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/NetworkFileSystem/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Json/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/UtilityShaders/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/InputCore/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/JsonUtilities/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/AutomationMessages/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/RenderCore/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Core/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Linux/LinuxCommonStartup/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Engine/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/AutomationWorker/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/StreamingPauseRendering/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Android/AndroidAudio/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/Android/AndroidLocalNotification/Public"
                ,"${UNREAL_ROOT}/Engine/Source/Runtime/AudioMixer/Public"

              ],
              "browse" : {
                  "limitSymbolsToIncludedHeaders" : true,
                  "databaseFilename" : ""
              }
          },
          {
              "name": "Win32",
              "includePath": ["c:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/include"],
              "browse" : {
                  "limitSymbolsToIncludedHeaders" : true,
                  "databaseFilename" : ""
              }
          }
      ]
  }
E_O_F

cat <<E_O_F> ${vscodeProps}
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "C++ Launch",
            "type": "cppdbg",
            "request": "launch",
            "program": "${ueLoc}",
            "args": ["${@}"],
            "stopAtEntry": false,
            "cwd": "\${workspaceRoot}",
            "environment": [],
            "externalConsole": true,
            "linux": {
                "MIMode": "gdb",
                "setupCommands": [
                    {
                        "description": "Enable pretty-printing for gdb",
                        "text": "-enable-pretty-printing",
                        "ignoreFailures": true
                    }
                ]
            },
            "osx": {
                "MIMode": "lldb"
            },
            "windows": {
                "MIMode": "gdb",
                "setupCommands": [
                    {
                        "description": "Enable pretty-printing for gdb",
                        "text": "-enable-pretty-printing",
                        "ignoreFailures": true
                    }
                ]
            }
        },
        {
            "name": "C++ Attach",
            "type": "cppdbg",
            "request": "attach",
            "program": "enter program name, for example \${workspaceRoot}/a.out",
            "processId": "\${command.pickProcess}",
            "linux": {
                "MIMode": "gdb",
                "setupCommands": [
                    {
                        "description": "Enable pretty-printing for gdb",
                        "text": "-enable-pretty-printing",
                        "ignoreFailures": true
                    }
                ]
            },
            "osx": {
                "MIMode": "lldb"
            },
            "windows": {
                "MIMode": "gdb",
                "setupCommands": [
                    {
                        "description": "Enable pretty-printing for gdb",
                        "text": "-enable-pretty-printing",
                        "ignoreFailures": true
                    }
                ]
            }
        }
    ]
}

E_O_F
}
