@echo off
REM =============================================
REM File: build_push.bat
REM Mục đích: Tự động đăng nhập Docker, build Docker image với build-arg,
REM và push image lên Docker Hub.
REM Có thể truyền tham số từ dòng lệnh:
REM   build_push.bat <image_tag>
REM =============================================

call "%~dp0env.bat"

if "%DOCKER_USERNAME%"=="" (
    echo [Error] Khong doc duoc credentials tu env.bat
    pause
    exit /b 1
)

REM Nhận tham số image_tag từ dòng lệnh hoặc nhập tương tác
if "%~1"=="" (
    set /p IMAGE_TAG=Nhap image tag:
) else (
    set IMAGE_TAG=%~1
)

set "IMAGE_NAME=mirofish/%IMAGE_TAG%"

echo.
echo =========================
echo Dang nhap docker hub...
echo =========================
echo.

docker login --username %DOCKER_USERNAME% --password %DOCKER_PASSWORD%
if errorlevel 1 (
    echo [Error] Docker login that bai!
    pause
    exit /b 1
)

echo.
echo =========================
echo Build Docker image: %IMAGE_NAME%
echo With Dockerfile: ./Dockerfile
echo =========================
echo.

docker build --no-cache -t %IMAGE_NAME% .
if errorlevel 1 (
    echo [Error] Docker build that bai!
    pause
    exit /b 1
)

echo.
echo =========================
echo Push Docker image: %IMAGE_NAME% len Docker Hub...
echo =========================
echo.

docker push %IMAGE_NAME%
if errorlevel 1 (
    echo [Error] Docker push that bai!
    pause
    exit /b 1
)

echo.
echo =========================
echo Hoan thanh. Happy Coding!
echo =========================
pause