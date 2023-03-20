# LocalizeKit (i18N) 

## Configuration
### (Optional) Setup Default Language
기본 언어를 설정합니다
별도로 설정하지 않은 경우 main bundle의 base를 가져옵니다
```
import LocalizeKit

LocalizeKit.shared.configure(
        localizingMode: .custom,
        defaultLanguage: "en"
    )
```

### (Optional) Setup Current Language
설정 언어를 변경합니다
```
import LocalizeKit
LocalizeKit.shared.setCurrentLanguage("en")
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

## Generate Manualy I18N
### Script 파일을 별도로 생성하고 직접 실행할 수 있습니다

New Run Script Phase에 아래 코드를 작성합니다
```
SCRIPT_DIR="${BUILD_DIR%/Build/*}/SourcePackages/checkouts/DKTUtils/LocalizeKit"
"${SCRIPT_DIR}/ManualScript"
```

최초 적용 시 GenerateI18N 파일이 생성되며 .i18n이 숨김파일로 생성됩니다
생성된 파일에 ko.lproj폴더 경로를 한 줄씩 입력하세요
tip. finder 에서 해당 파일을 끌어다 놓으면 full path가 자동으로 입력됩니다
```
eg.
/Users/../Desktop/.../ProjectName/Packages/NoteScene/Sources/NoteScene/Localizable/ko.lproj
```
