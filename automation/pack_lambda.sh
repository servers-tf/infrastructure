#! /bin/bash
: '
    Simple script to help create the zip files needed for AWS Lambda
    Only packs Boto3 as a dependecy for now
'

source_code=$1
zip_name="${source_code%.*}.zip"

if [[ -z $source_code ]]; then
    echo "No source code provided! Please select a file to pack!"
    exit 1
fi

# Create temp dir
temp_dir=$(mktemp -d)
echo "Created temp dir for build $temp_dir"

# Install Boto3
echo "Installing Boto3"
/usr/bin/python3.6 -m pip -q install boto3 -t $temp_dir

# Copy Source
echo "Copying source file $source_code"
cp $source_code $temp_dir/

# Zip it all up
echo "Creating archive $zip_name"
pushd $temp_dir > /dev/null
zip -q -r $zip_name .
popd > /dev/null

# Copy it all back
cp $temp_dir/$zip_name .
echo "Done! md5sum = `md5sum $zip_name | cut -f1 -d' '`"
