cmake_minimum_required(VERSION 3.28...3.31)

project(Seiyapkg VERSION 0.1.0 LANGUAGES C CXX)

if (APPLE)
    enable_language(OBJCXX Swift)
endif ()

# 设置语言标准
if (WIN32)
    set(CMAKE_C_STANDARD 17)
else ()
    set(CMAKE_C_STANDARD 23)
endif ()
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 23)

# 设置开启显示详细的构建过程
set(CMAKE_VERBOSE_MAKEFILE ON)

add_definitions(-DEXPORTING)
include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${PROJECT_BINARY_DIR})

set(LIB_NAME "MTSeiyapkg")

file(GLOB_RECURSE SEIYAPKG_SOURCES
        seiyapkg/*.cpp
        quark/core/string/*.cpp
        quark/core/uuid/*.cpp
        quark/infra/result/*.cpp)

if (APPLE)
    list(APPEND SEIYAPKG_SOURCES module.modulemap)
endif ()
add_library(${LIB_NAME} SHARED ${SEIYAPKG_SOURCES})

find_package(lunasvg CONFIG REQUIRED)
target_link_libraries(${LIB_NAME} PRIVATE lunasvg::lunasvg)

if (APPLE)
    set_target_properties(${LIB_NAME} PROPERTIES
            FRAMEWORK TRUE
            FRAMEWORK_VERSION A
            MACOSX_FRAMEWORK_IDENTIFIER xyz.huable.${LIB_NAME}
            VERSION 0.0.1
            SOVERSION 0.0.1
            PUBLIC_HEADER "src/seiyapkg/seiyapkg.h"
            MACOSX_BUNDLE TRUE)
endif ()

#install(TARGETS ${LIB_NAME}
#        RUNTIME DESTINATION .
#         LIBRARY DESTINATION .
#         ARCHIVE DESTINATION .
#)


#install(TARGETS ${LIB_NAME}
#        RUNTIME_DEPENDENCY_SET ${LIB_NAME}Deps
#        DESTINATION .
#)
#install(RUNTIME_DEPENDENCY_SET ${LIB_NAME}Deps)

set(TARGET_DLL "${CMAKE_BINARY_DIR}/${LIB_NAME}.dll")

# 确保目标 DLL 被安装
install(FILES ${TARGET_DLL}
        DESTINATION .
)

# 使用 install(CODE) 解析和安装运行时依赖
install(CODE [[
        message(WARNING "TARGET_DLL: ${CMAKE_INSTALL_PREFIX}/MTSeiyapkg.dll")
    # 获取目标 DLL 的运行时依赖
    file(GET_RUNTIME_DEPENDENCIES
        LIBRARIES "${CMAKE_INSTALL_PREFIX}/MTSeiyapkg.dll"
        RESOLVED_DEPENDENCIES_VAR RESOLVED_DEPS
        UNRESOLVED_DEPENDENCIES_VAR UNRESOLVED_DEPS
        DIRECTORIES "${CMAKE_BINARY_DIR}" "C:/path/to/extra/libs"
    )
        message(WARNING "RESOLVED_DEPS: ${RESOLVED_DEPS}")

    # 过滤掉系统 DLL
    set(NON_SYSTEM_DLLS)
    foreach(DEP ${RESOLVED_DEPS})
        if(NOT "${DEP}" MATCHES "C:/Windows/System32" AND NOT "${DEP}" MATCHES "C:/Windows/SysWOW64")
            list(APPEND NON_SYSTEM_DLLS "${DEP}")
        endif()
    endforeach()

    # 将非系统依赖安装到 bin 目录
    if(NON_SYSTEM_DLLS)
        file(INSTALL
            FILES ${NON_SYSTEM_DLLS}
            DESTINATION "${CMAKE_INSTALL_PREFIX}/."
        )
    endif()

    # 报告未解析的依赖（如果有）
    if(UNRESOLVED_DEPS)
        message(WARNING "UNRESOLVED_DEPS: ${UNRESOLVED_DEPS}")
    endif()
]])

# 可选：提示安装 MSVC 运行时
install(CODE [[
    message("Visual C++ Redistributable")
]])



add_executable(CMain examples/cmain/main.c)
add_dependencies(CMain ${LIB_NAME})
target_link_libraries(CMain PRIVATE ${LIB_NAME})
add_executable(CxxMain examples/cxxmain/main.cpp)
add_dependencies(CxxMain ${LIB_NAME})
target_link_libraries(CxxMain PRIVATE ${LIB_NAME})