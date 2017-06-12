
#!/bin/bash

repo_dir="$HOME/mirror"
repo_dists=$1
repo_sect=$2
repo_arch=$3
repo_pkglist="$repo_dir/dists/$repo_dists/$repo_sect/binary-$repo_arch/Packages"
#repo_mirror="http://kartolo.sby.datautama.net.id/debian"
repo_mirror="http://archive.debian.org/debian"

if [ ! -f "$repo_pkglist" ]
then
 echo "Error:"
 echo "- $repo_pkglist"
 echo "File not exists."
fi

for i in `cat $repo_pkglist | grep Filename: | awk '{print $2}'`
do
 if [ ! -f "$repo_dir/$i" ]
 then
  echo $repo_dir/$i
  mkdir -p `dirname $repo_dir/$i`
  wget -c $repo_mirror/$i -O $repo_dir/$i
 fi
done

