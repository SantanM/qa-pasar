#!/usr/bin/env

apt install dirmngr apt-transport-https ca-certificates software-properties-common libssl-dev libxml2-dev -y

gpg --keyserver keyserver.ubuntu.com --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7'
gpg --armor --export '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' | gpg --dearmor | tee /usr/share/keyrings/cran.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/cran.gpg] https://cloud.r-project.org/bin/linux/debian bookworm-cran40/" | tee /etc/apt/sources.list.d/cran.list

apt update

apt install r-base r-base-dev

export JAVA_HOME=/usr/lib/jvm/openjdk-11
export PATH="$JAVA_HOME/bin::/root/.cargo/bin:$PATH"
export LD_LIBRARY_PATH=/usr/lib/jvm/openjdk-11/lib/server

JAVA_HOME_11=/usr/lib/jvm/openjdk
arch="$(dpkg --print-architecture)"; case "$arch" in 'amd64') downloadUrl='https://github.com/AdoptOpenJDK/openjdk11-upstream-binaries/releases/download/jdk-11.0.16%2B8/OpenJDK11U-jdk_x64_linux_11.0.16_8.tar.gz'; ;; 'arm64') downloadUrl='https://github.com/AdoptOpenJDK/openjdk11-upstream-binaries/releases/download/jdk-11.0.16%2B8/OpenJDK11U-jdk_aarch64_linux_11.0.16_8.tar.gz'; ;; *) echo >&2 "error: unsupported architecture: '$arch'"; exit 1 ;; esac; wget --progress=dot:giga -O openjdk.tgz "$downloadUrl"; 
sudo mkdir -p ${JAVA_HOME_11} 
sudo tar --extract --file openjdk.tgz --directory "$JAVA_HOME_11" --strip-components 1 --no-same-owner ;

sudo update-alternatives --install /usr/bin/java java ${JAVA_HOME_11}/bin/java 100

sudo R CMD javareconf

java -version

sudo apt install r-cran-rjava

sudo Rscript -e 'install.packages(c("remotes, shiny"))'
sudo Rscript -e 'remotes::install_github("OHDSI/DataQualityDashboard")'
