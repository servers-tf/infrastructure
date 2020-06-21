set -e

SOURCE_DIR=$(realpath $1)
REQUIREMENTS_FILE="$SOURCE_DIR/$2"
OUTPUT_FILE=$(realpath $3)
BUILD_DIR=$(mktemp -d)

pushd $BUILD_DIR
    echo "Coping source code into build directory..."
    cp -R $SOURCE_DIR/* .

    echo "Installing requirements..."
    python3 -m pip install -t . -r $REQUIREMENTS_FILE

    echo "Creating archive..."
    zip -q -r $OUTPUT_FILE .
popd
