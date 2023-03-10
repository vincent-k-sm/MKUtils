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

## For Main Project
### New Run Script Phase에 아래 코드를 작성합니다
 ```
touch tempI18N.swift
echo "struct I18N {" >> tempI18N.swift
file="${SRCROOT}/Resource/ko.lproj/Localizable.strings" # Localizable.strings 파일 위치로 고쳐주세요.
while IFS= read -r line
do
variableName=$(echo ${line%%=*})
if [ "$variableName" != "" ]
then
echo "    static let $variableName = \"$variableName\".localized" >> tempI18N.swift
fi
done <"$file"

echo "}" >> tempI18N.swift

cat "tempI18N.swift" > ${SRCROOT}/Resource/I18N.swift # Output 파일 위치로 고쳐주세요.
rm tempI18N.swift
```


## AutoGenerate I18N 
### New Run Script Phase에 아래 코드를 작성합니다
```
# Type a script or drag a script file from your workspace to insert its path.
export ROOT_DIRECTORY="${SRCROOT}/Packages" # Package가 존재하는 Root폴더
export TARGETS="PhotoScene NoteScene" # 적용할 대상 Package 

SCRIPT_DIR="${BUILD_DIR%/Build/*}/SourcePackages/checkouts/MKUtils/Resources/LocalizeKit"
${SCRIPT_DIR}/Run

```

## Generate Maualy I18N
### Script 파일을 별도로 생성하고 직접 실행할 수 있습니다

New Run Script Phase에 아래 코드를 작성합니다
```
SCRIPT_DIR="${BUILD_DIR%/Build/*}/SourcePackages/checkouts/MKUtils/MKLocalize"
"${SCRIPT_DIR}/ManualScript"
```

최초 적용 시 GenerateI18N 파일이 생성되며 Xcode로 열립니다.
생성된 파일 내 옵션을 정확히 작성하세요
```
# 패키지 파일의 Root 폴더 위치를 설정하세요
ENV_PACKAGE_ROOT="Packages"
# 로컬라이징 대상을 지정하세요 (Main 프로젝트 제외)
ENV_PACKAGE_TARGETS=(PhotoScene NoteScene)
```
