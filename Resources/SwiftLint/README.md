# MKUtils - Swift Lint


## 아래와 같이 Application 폴더(이름 무관)를 생성한 뒤 배치해주세요
```

- Root
ㄴ DIR
   ㄴ SceneDelegate
   ㄴ AppDelegate
-- DIR
-- ....
```


## New Run Script Phase 추가
```
# Default Warning in Lint
"${BUILD_DIR%/Build/*}/SourcePackages/checkouts/MKUtils/Resources/SwiftLint/Run"
 
# Auto fix all Lint
# "${BUILD_DIR%/Build/*}/SourcePackages/checkouts/MKUtils/Resources/SwiftLint/RunAuto"
```
