TIMEOFEXEC=3

if [ "$MAGISK" == true ]; then
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/xposed.prop $UNITY/xposed.prop
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/app_process32_magisk $UNITY$SYS/bin/app_process32
  $IS64BIT && $CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/app_process64_magisk $UNITY$SYS/bin/app_process64
else
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/xposed.prop $UNITY$SYS/xposed.prop
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/app_process32 $UNITY$SYS/bin/app_process32
  $IS64BIT && $CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/app_process64 $UNITY$SYS/bin/app_process64
  test $API -ge 22 && find $SYS $VEN -type f -name '*.odex.gz' 2>/dev/null | while read f; do mv "$f" "$f.xposed"; done
fi
$CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/dex2oat $UNITY$SYS/bin/dex2oat
$CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/oatdump $UNITY$SYS/bin/oatdump
$CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/patchoat $UNITY$SYS/bin/patchoat
$CP_PRFX $INSTALLER/custom/$API/$ARCH/lib/libart.so $UNITY$SYS/lib/libart.so
$CP_PRFX $INSTALLER/custom/$API/$ARCH/lib/libart-compiler.so $UNITY$SYS/lib/libart-compiler.so
$CP_PRFX $INSTALLER/custom/$API/$ARCH/lib/libsigchain.so $UNITY$SYS/lib/libsigchain.so
$CP_PRFX $INSTALLER/custom/$API/$ARCH/lib/libxposed_art.so $UNITY$SYS/lib/libxposed_art.so
if $IS64BIT; then
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib64/libart.so $UNITY$SYS/lib64/libart.so
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib64/libart-compiler.so $UNITY$SYS/lib64/libart-compiler.so
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib64/libart-disassembler.so $UNITY$SYS/lib64/libart-disassembler.so
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib64/libsigchain.so $UNITY$SYS/lib64/libsigchain.so
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib64/libxposed_art.so $UNITY$SYS/lib64/libxposed_art.so
else
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib/libart-disassembler.so $UNITY$SYS/lib/libart-disassembler.so
fi
