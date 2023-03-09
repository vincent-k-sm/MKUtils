# MKLocalize (i18N) 

## Configuration
### (Optional) Setup Default Language
기본 언어를 설정합니다
별도로 설정하지 않은 경우 main bundle의 base를 가져옵니다
```
import MKLocalize

MKLocalize.shared.configure(
        localizingMode: .custom,
        defaultLanguage: "en"
    )
```

### (Optional) Setup Current Language
설정 언어를 변경합니다
```
import MKLocalize
MKLocalize.shared.setCurrentLanguage("en")
```


# Codegen I18N
## (Auto) New Run Script Phase에 아래 코드를 작성합니다
```
# Type a script or drag a script file from your workspace to insert its path.

ENABLE_SCRIPT="false" # 로컬라이징 작업이 있는 경우만 sync하기를 권장합니다  

if $ENABLE_SCRIPT == "true"; then
    SCRIPT_DIR="${BUILD_DIR%/Build/*}/SourcePackages/checkouts/MKUtils/Resources/LocalizeKit"
    cd "$SCRIPT_DIR"
    
    # <-p> 패키지 파일의 Root 폴더 위치를 설정하세요
    # <-t> 스크립트가 동작할 패키지 목록을 배열형태로 설정하세요 (eg. PhotoScene NoteScene)
    xcrun -sdk macosx swift run Localizing generate \
    -p "${SRCROOT}/Packages" \
    -t "PhotoScene" 

    rm -rf "$SCRIPT_DIR/.build" # 미 삭제시 바이너리에 빌드파일이 포함됩니다 삭제하지마세요
else
    echo "I18N Script Disabled"
fi

```


## (Manual) 수동으로 스크립트를 실행합니다
### 매 빌드 시 자동 적용하는 경우 과도한 버퍼가 사용될 수 있습니다
### New Run Script Phase에 아래 코드를 작성합니다
```
SCRIPT_DIR="${BUILD_DIR%/Build/*}/SourcePackages/checkouts/MKUtils/MKLocalize"
"${SCRIPT_DIR}/ManualScript"
```
