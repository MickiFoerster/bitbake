#export PATH=<path to bitbake/bin>:$PATH

if [ ! -d ${BBPATH}/build/conf ]; then
  mkdir -p ${BBPATH}/build/conf
fi
cd ${BBPATH}/build
export BBPATH=$PWD
