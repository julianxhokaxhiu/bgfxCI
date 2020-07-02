Set-Location ${env:buildPath}\bgfx\.build\win32_vs2019\bin
mkdir ..\bin_new | Out-Null

get-childitem *.exe | ForEach-Object {
  Move-Item $_.Name ..\bin_new;

  $pdbName = $_.BaseName + ".pdb";
  if (Test-Path $pdbName) {
    Move-Item $pdbName ..\bin_new;
  }

  $libName = $_.BaseName + ".lib";
  if (Test-Path $libName) {
    Move-Item $libName ..\bin_new;
  }
}

mkdir ..\lib\bgfx | Out-Null
Move-Item *.lib ..\lib\bgfx
Move-Item *.pdb ..\lib\bgfx
Copy-Item ..\..\..\include .. -Recurse
Copy-Item ..\..\..\src\bgfx_shader.sh ..\include\bgfx
Copy-Item ..\..\..\src\bgfx_compute.sh ..\include\bgfx
Copy-Item -r ..\..\..\..\bx\include .. -Force
Copy-Item -r ..\..\..\..\bimg\include .. -Force
Set-Location ..
Remove-Item -r bin
Remove-Item -r obj
Move-Item bin_new bin

Get-ChildItem bin\* -Recurse | ForEach-Object {
  Rename-Item -Path $_.FullName -NewName $_.Name.replace($env:_RELEASE_CONFIGURATION,"");
}

Set-Location ..\..
mkdir ${env:buildPath}\.dist | Out-Null
Compress-Archive -Path .build\win32_vs2019\* -DestinationPath "${env:buildPath}\.dist\${env:_RELEASE_NAME}-${env:_RELEASE_VERSION}.zip"
