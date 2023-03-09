# MKUtils - Localizing i18N 

## New Run Script Phase에 아래 코드를 작성합니다
```

SCRIPT_DIR="${BUILD_DIR%/Build/*}/SourcePackages/checkouts/MKUtils/Resources/LocalizeKit"
cd "$SCRIPT_DIR"

# <-p> 패키지 파일의 Root 폴더 위치를 설정하세요
# <-t> 스크립트가 동작할 패키지 목록을 배열형태로 설정하세요 (eg. PhotoScene NoteScene)

xcrun -sdk macosx swift run Localizing generate \
-p "${SRCROOT}/Packages" \
-t "PhotoScene" 

rm -rf "$SCRIPT_DIR/.build" # 미 삭제시 바이너리에 빌드파일이 포함됩니다 삭제하지마세요


```

