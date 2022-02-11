RESET='\033[0m'           # Text Reset
BLACK='\033[0;30m'        # Black
RED='\033[0;31m'          # Red
GREEN='\033[0;32m'        # Green
YELLOW='\033[0;33m'       # Yellow
BLUE='\033[0;34m'         # Blue
PURPLE='\033[0;35m'       # Purple
CYAN='\033[0;36m'         # Cyan
WHITE='\033[0;37m'        # White

CODENAME=""
DIR=""

echo -e "${YELLOW}"
echo "Enter full rom dir"
echo -e "${RESET}"
read DIR

echo -e "${YELLOW}"
echo "Enter codename"
echo -e "${RESET}"
read CODENAME

echo -e "${GREEN}"
echo "Creating json for OTA"
echo -e "${YELLOW}"
echo "{"
echo '"response": ['
echo "{"
echo ' "datetime":' "\"$(grep ro\.build\.date\.utc "$DIR"/out/target/product/"$CODENAME"/system/build.prop | cut -d= -f2)\","
echo ' "filename":' "\"$(basename $(ls "$DIR"/out/target/product/"$CODENAME"/CipherOS*.zip))\","
echo ' "id":' "\"$((cat "$DIR"/out/target/product/"$CODENAME"/CipherOS*.zip.md5sum) | cut -d ' ' -f1)\","
echo ' "romtype":'"\"STABLE\","
echo ' "size":' "\"$(stat -c%s "$DIR"/out/target/product/"$CODENAME"/CipherOS*.zip)\","
echo ' "url":' "\"https://master.dl.sourceforge.net/project/CipherOS/Cipher-2.x/LYNX/"$CODENAME"/$(basename $(ls "$DIR"/out/target/product/"$CODENAME"/CipherOS*.zip))\","
echo ' "version":' "\"2.5-LYNX\""
echo "}"
echo "]"
echo "}"
