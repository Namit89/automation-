creating a bash script to extend the /opt /home
varvgs=`vgs --unit m | grep -i rootvg | awk '{print $6}' | awk -F "." '{print $1}'`
lv_var_spcae=`df -Thm |grep -iw lv_var | awk '{print $5}'`
lv_opt_space=`df -Thm |grep -iw lv_opt | awk '{print $5}'`
lv_home_space=`df -Thm |grep -iw lv_home | awk '{print $5}'`
SpaceIncrese () {
varname="rootvg-"
varname+=$filesystemName
requiredSpace=$(echo "($patching_space-$varfilesystem)"| bc -l);
varvgs=$(echo "($varvgs-100)"| bc -l);
if (( $(echo "$varvgs > $requiredSpace" |bc -l) ))
then
lvextend -r -L +${requiredSpace}M /dev/mapper/$varname;
echo "space incresed successfully";
else
echo "/vg has not enough space";
echo $varvgs
exit
fi
}
if [ "$lv_var_spcae" -le 1433 ]
then
patching_space=1433;
varfilesystem=$lv_var_spcae
filesystemName="lv_var"
SpaceIncrese
else
echo "lv_var has enough space to perform patching" $lv_var_spcae
fi
if [ "$lv_opt_space" -le 500 ]
then
patching_space=500;
varfilesystem=$lv_opt_space
filesystemName="lv_opt"
SpaceIncrese
else
echo "lv_opt has enough space to perform patching" $lv_opt_space
fi
if [ "$lv_home_space" -le 100 ]
then
patching_space=100;
varfilesystem=$lv_home_space
filesystemName="lv_home"
SpaceIncrese
else
echo "lv_home has enough space to perform patching" $lv_home_space
fi
