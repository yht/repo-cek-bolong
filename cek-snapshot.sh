#!/bin/bash

log_note=`date '+%Y%m%d%H%M'`
log_file="tmp/$1_$2_$3_$log_note.txt"
alias urldecode='sed "s@+@ @g;s@%@\\\\x@g" | xargs -0 printf "%b"'
alias tagplus='sed "s/+/\\+/g"'

repo_dir="$HOME/mirror"
repo_dists=$1
repo_sect=$2
repo_arch=$3
repo_pkglist="$repo_dir/dists/$repo_dists/$repo_sect/binary-$repo_arch/Packages"
repo_mirror="http://snapshot.debian.org"

save_log() {
  echo "$pkg_name: $pkg_deb ($pkg_ver)" >> $log_file
  echo "$pkg_url" >> $log_file
  echo $repo_mirror$pkg_link >> $log_file
  echo "$(md5sum $repo_dir/$i)" >> $log_file
  echo "" >> $log_file
}

if [ ! -f "$repo_pkglist" ]
then
 echo "Error:"
 echo "- $repo_pkglist"
 echo "File not exists."
fi

if [ ! -d "tmp/" ]
then
 mkdir -p tmp
fi

if [ -f "$log_file" ]
then
 rm "$log_file"
fi

for i in `cat $repo_pkglist | grep Filename: | awk '{print $2}'`
do
 if [ ! -f "$repo_dir/$i" ]
 then
  echo $repo_dir/$i
  pkg_dir=`dirname $repo_dir/$i`
  pkg_name=${pkg_dir##*/}
  pkg_debhtml=${i##*/}
  pkg_deb=`echo $pkg_debhtml | urldecode`
  pkg_verhtml=`echo $pkg_debhtml | awk -F_ '{print $2}'`
  pkg_ver=`echo $pkg_deb | awk -F_ '{print $2}'`
  echo "$pkg_name: $pkg_deb ($pkg_ver)"
  pkg_html="tmp/$pkg_name-$pkg_ver.html"
  pkg_url="$repo_mirror/package/$pkg_name/$pkg_verhtml/"
  echo $pkg_url
  curl $pkg_url > "$pkg_html"
  pkg_link=`cat "$pkg_html" | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep "$pkg_deb"`
  mkdir -p $pkg_dir
  wget -c -O "$repo_dir/$i" $repo_mirror$pkg_link
  save_log
 fi
done
