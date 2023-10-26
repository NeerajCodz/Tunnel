
source colorcodes.sh
##IMPORTANT IDENTIFIERS
#Directories---
pro_dir=$(pwd) #project directory
server_dir="${pro_dir}/.server" #server directory
www_dir="${pro_dir}/.server/www" #www directory
assets_dir="${pro_dir}/assets" #assets directory
dumps_dir="${pro_dir}/assets/dumps" #dumps directory
update_dir="${pro_dir}/assets/update" #update dir
ssh_dir="$HOME/.ssh" #ssh directory

repo_link="https://github.com/NeerajCodz/Tunnel"

#Prompt---
prompt="$(echo -e "${GREEN}>> ${ULYELLOW}Tunnel${NF} >>${NA} ${CYAN}")"

#variables
id=""

#Normal Banner
banner(){
    echo -e " "
    echo -e "${MAGENTA}-----------------------------------------------------------${NC} "
	echo -e "${MAGENTA}|       ${CYAN} ██████╗██╗     ██╗███████╗████████╗██╗   ██╗     ${MAGENTA}|${NC}"
	echo -e "${MAGENTA}|       ${CYAN}██╔════╝██║     ██║██╔════╝╚══██╔══╝╚██╗ ██╔╝     ${MAGENTA}|${NC}"
	echo -e "${MAGENTA}|       ${CYAN}██║     ██║     ██║█████╗     ██║    ╚████╔╝      ${MAGENTA}|${NC}"
	echo -e "${MAGENTA}|       ${CYAN}██║     ██║     ██║██╔══╝     ██║     ╚██╔╝       ${MAGENTA}|${NC}"
	echo -e "${MAGENTA}|       ${CYAN}╚██████╗███████╗██║██║        ██║      ██║        ${MAGENTA}|${NC}"
	echo -e "${MAGENTA}|       ${CYAN} ╚═════╝╚══════╝╚═╝╚═╝        ╚═╝      ╚═╝        ${MAGENTA}|${NC}"
	echo -e "${MAGENTA}-----------------------------------------------------------${NC}"
        echo -e ""
}
# Credits banner
cbanner(){
    echo -e " "
    echo -e "${MAGENTA}-----------------------------------------------------------${NC} "
	echo -e "${MAGENTA}|       ${CYAN} ██████╗██╗     ██╗███████╗████████╗██╗   ██╗     ${MAGENTA}|${NC}"
	echo -e "${MAGENTA}|       ${CYAN}██╔════╝██║     ██║██╔════╝╚══██╔══╝╚██╗ ██╔╝     ${MAGENTA}|${NC}"
	echo -e "${MAGENTA}|       ${CYAN}██║     ██║     ██║█████╗     ██║    ╚████╔╝      ${MAGENTA}|${NC}"
	echo -e "${MAGENTA}|       ${CYAN}██║     ██║     ██║██╔══╝     ██║     ╚██╔╝       ${MAGENTA}|${NC}"
	echo -e "${MAGENTA}|       ${CYAN}╚██████╗███████╗██║██║        ██║      ██║        ${MAGENTA}|${NC}"
	echo -e "${MAGENTA}|       ${CYAN} ╚═════╝╚══════╝╚═╝╚═╝        ╚═╝      ╚═╝        ${MAGENTA}|${NC}"
	echo -e "${MAGENTA}-----------------------------------------------------------${NC}"
	echo -e "${BOLDBLUE}           ᴠᴇʀsɪᴏɴ 1.4               ＢＹ －ＡＬＹＧＮＴ           ${NC}"
        echo -e ""
}
#Small Banner
sbanner(){
	echo -e " "
	echo -e "${CYAN} ░█▀▀░█░░░▀█▀░█▀▀░▀█▀░█░█ ${NC}"
	echo -e "${CYAN} ░█░░░█░░░░█░░█▀▀░░█░░███ ${NC}"
	echo -e "${CYAN} ░▀▀▀░▀▀▀░▀▀▀░▀░░░░▀░░░▀░ ${NC}"
	echo -e "${NC} "
}

## Directories
directories(){
        if [[ ! -d "${server_dir}" ]]; then
                mkdir -p "${server_dir}"
                echo -e "\n${BLUE}[${WHITE}+${BLUE}]${GREEN} Created server directory"
        fi
        if [[ ! -d "${logs_dir}" ]]; then
                mkdir -p "${logs_dir}"
                echo -e "\n${BLUE}[${WHITE}+${BLUE}]${GREEN} Created Logs directory"
        fi
        
        if [[ ! -d "${fetch_dir}" ]]; then
                mkdir "${fetch_dir}"
                echo -e "\n${BLUE}[${WHITE}+${BLUE}]${GREEN} Created Fetch directory"
        fi     
        if [[ -d "${www_dir}" ]]; then
                rm -rf "${www_dir}"
                mkdir -p "${www_dir}"
                echo -e "\n${BLUE}[${WHITE}+${BLUE}]${GREEN} Created www directory"
        else
                mkdir -p "${www_dir}"
                
                echo -e "\n${BLUE}[${WHITE}+${BLUE}]${GREEN} Created www directory"
        fi
        if [[ -e ".cld.log" ]]; then
                rm -rf ".cld.log"
        fi
}
#Dependencies
dependencies() {
        echo -e "\n${BLUE}[${WHITE}+${BLUE}]${GREEN} Installing required packages..."
    if [[ -d "/data/data/com.termux/files/home" ]]; then
        if [[ `command -v proot` ]]; then
            printf ''
        else
                        echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing package : ${YELLOW}proot${CYAN}${NC}"
            pkg install proot resolv-conf -y
        fi
    fi

        if [[ `command -v php` && `command -v wget` && `command -v curl` && `command -v unzip` ]]; then
                echo -e "\n${GREEN}[${WHITE}#${GREEN}]${GREEN} Packages already installed."
        else
                pkgs=(php curl wget )
                for pkg in "${pkgs[@]}"; do
                        type -p "$pkg" &>/dev/null || {
                                echo -e "\n${GREEN}[${WHITE}#${GREEN}]${CYAN} Installing package : ${YELLOW}$pkg${CYAN}${NC}"
                                if [[ `command -v pkg` ]]; then
                                        pkg install "$pkg" -y
                                elif [[ `command -v apt` ]]; then
                                        apt install "$pkg" -y
                                elif [[ `command -v apt-get` ]]; then
                                        apt-get install "$pkg" -y
                                elif [[ `command -v pacman` ]]; then
                                        sudo pacman -S "$pkg" --noconfirm
                                elif [[ `command -v dnf` ]]; then
                                        sudo dnf -y install "$pkg"
                                else
                                        echo -e "\n${RED}[${WHITE}!${RED}]${RED} Unsupported package manager, Install packages manually."
                                        { reset_color; exit 1; }
                                fi
                        }
                done
        fi

}

## Reset terminal colors
reset_color() {
    tput sgr0   # reset attributes
    tput op     # reset color

    return
}

## Exit message
msg_exit() {
        { clear; banner; echo; }
        echo -e "${GREENBG}${BLACK} Thank you for using this tool. Have a good day.${RESETBG}\n"
        { reset_color; exit 0; }
}

## Kill already running process
kill_all() {
    kill_php
    kill_ngrok
    kill_cloudflared

}

#check whether execute permission is granted
xpermission(){
	if [[ -x "tunnel.sh" ]];then
		echo -e "\n${GREEN}[${WHITE}#${GREEN}]${GREEN} Execute Permission Granted!!"
	else
	        chmod 777 tunnel.sh
	        echo -e "\n${GREEN}[${WHITE}#${GREEN}]${GREEN} Execute Permission Granted!!"
	fi
}

#check for updates
update(){
	status
	if [ $plainnetstats == "online" ]; then
                { clear; banner; }
                lat_ver=$( cat ${update_dir}/version.txt )
                echo -e "\n${GREEN}[${WHITE}#${GREEN}]${GREEN} Updating ( Version: ${lat_ver} ) ${NC} "
		        cd ${pro_dir}
                lat_ver=$( cat ${update_dir}/version.txt )
                git reset --hard
                git pull
                echo -e " "
                echo -e "\n${GREEN}[${WHITE}#${GREEN}]${GREEN} SUCCESSFULLY UPDATED!! ( Version: ${lat_ver} ) ${NC} "
                sleep 2
                echo -e "\n${GREEN}[${WHITE}#${GREEN}]${MAGENTA} RESTARTING THE TOOL!!${NC} "
                cd ${pro_dir}
                chmod 777 clifty.sh
                bash clifty.sh
                
	else
		echo -e "\n${GREEN}[${WHITE}!${GREEN}]${RED}Your offline, Check your internet and try again."
		sleep 5
		homepage
	fi
}

## Tunnel selection
tunnel_menu() {
echo -e "${ULWHITE}${BOLDWHITE}CHOOSE A TUNNEL TYPE${NF} : ${NC}"
echo -e " "
echo -e "${RED}[${WHITE}01${RED}]${YELLOW} Localhost    ${RED}[${CYAN}For Devs${RED}]"
echo -e "${RED}[${WHITE}02${RED}]${YELLOW} Ngrok.io     ${RED}[${CYAN}Need to create account${RED}]"
echo -e "${RED}[${WHITE}03${RED}]${YELLOW} Cloudflared  ${RED}[${CYAN}Best${RED}]"
echo -e "${RED}[${WHITE}04${RED}]${YELLOW} LocalXpose   ${RED}[${CYAN}Max 15 mins${RED}]"
echo -e "${RED}[${WHITE}05${RED}]${YELLOW} Serveo.net   ${RED}[${CYAN}Max 15 mins${RED}]"
echo -e "${NC}"

read -p "${prompt}" tuchoice
        case $tuchoice in
                1 | 01)
                        tunnel_name="LocalHost"
                        tunnel_id="localhost"
                        start_localhost;;
                2 | 02)
                        tunnel_name="Ngrok"
                        tunnel_id="ngrok"
                        check_net_tunnel ${tunnel_id};;
                3 | 03)
                        tunnel_name="Cloudflared"
                        tunnel_id="cloudflared"
                        check_net_tunnel ${tunnel_id};;
		        4 | 04)
                        tunnel_name="LocalXpose"
                        tunnel_id="localxpose"
                        check_net_tunnel ${tunnel_id};;
                5 | 05)
                        tunnel_name="Serveo.net"
                        tunnel_id="serveo"
                        check_net_tunnel ${tunnel_id};;
                *)
                        echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Invalid Option, Try Again..."
                        { sleep 1; clear; tunnel_menu; };;
        esac
}


## TUNNEL - ngrok
check_ngrok(){
    { clear; banner; echo -e ""; }
	if [ ! -e "${server_dir}/ngrok" ]; then
		echo -e " "
        echo -e "${GREEN}[${WHITE}!${GREEN}]${GREEN} NGROK NOT INSTALLED!!${BLUE}"
        echo -e "${GREEN}[${WHITE}?${GREEN}]${ULWHITE}${BOLDWHITE} Do you want to install now? ${NF} : ${NC}"
        echo -e " " 
        echo -e "${BLUE}[1/Y]  ${CYAN} YES ${NC}"
        echo -e "${BLUE}[2/N/*]${CYAN} NO ${NC}"
        echo -e "${NC}"
        temprompt="$(echo -e "${YELLOW}>> ${BLUE}")"
	    read -p "${temprompt}"
		case $REPLY in
		Y | y)
			install_ngrok
			ngrok_token_check;;

		N | n | *)
			tunnel_menu;;

		esac
	else
		ngrok_token_check
	fi
}
install_ngrok() {
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing ngrok...${NC}"
		arch=`uname -m`
		if [[ ("$arch" == *'arm'*) || ("$arch" == *'Android'*) ]]; then
			download 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz' 'ngrok'
		elif [[ "$arch" == *'aarch64'* ]]; then
			download 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz' 'ngrok'
		elif [[ "$arch" == *'x86_64'* ]]; then
			download 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz' 'ngrok'
		else
			download 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-386.tgz' 'ngrok'
		fi
}
ngrok_token_check(){
        if [ -f "${HOME}/.config/ngrok/ngrok.yml" ]; then
        echo -e "${RED}[${WHITE}?${RED}]${ULWHITE}${BOLDWHITE}Change ngrok authtoken ${NA}"
        echo -e "\n\n${BOLDWHITE} NOTE : ${NF}${WHITE}Ngrok may ban your account. So, create a new account and setup new authtoken ${NA}"
        echo -e "${BLUE}[1/Y]  ${CYAN} Setup new authtoken ${NC}"
        echo -e "${BLUE}[2/N/*]${CYAN} Use old authtoken ${NC}"
        echo -e "${NC}"
        temprompt="$(echo -e "${YELLOW}>> ${BLUE}")"
	    read -p "${temprompt}"
            case $REPLY in
            1 | Y | y | yes | Yes | YES)
                ngrok_token_setup;;
            *)
                start_ngrok;;
            esac
        else
                echo -e "\n${GREEN}[${WHITE}#${GREEN}]${BLUE} Setting up authtoken"
                ngrok_token_setup
        fi
}
ngrok_token_setup(){
    rm -rf $HOME/.ngrok2
    temprompt="$(echo -e "${GREEN}[${WHITE}?${GREEN}]${ULWHITE}${BOLDWHITE} ENTER YOUR AUTHTOKEN${NA}${YELLOW} >> ${NA}")"
	read -p "${temprompt}" ntoken
	${server_dir}/ngrok config add-authtoken ${ntoken}
	echo -ne "\n${RED}[${WHITE}-${RED}]${GREEN} Upgraded ngrok configurations"
    sleep 2
	clear
	banner
	start_ngrok
}
ngrok_region() {
        echo -e ""
        echo -e "${ULWHITE}${BOLDWHITE}ENTER YOUR PREFERED REGION${NA}${YELLOW} >> ${NA}"
        temprompt="$(echo -e " ${GREEN}(Example: us eu au ap sa jp in) ${NA}${YELLOW}>> ")"
	read -p "${temprompt}" ngrokregion
	case $ngrokregion in
	"us" | "US")
		ngrokregion="us";;
	"eu" | "EU")
		ngrokregion="eu";;
	"au" | "AU")
		ngrokregion="au";;
	"ap" | "AP")
		ngrokregion="ap";;
	"sa" | "SA")
		ngrokregion="sa";;
	"jp" | "JP")
		ngrokregion="jp";;
	"in" | "IN")
		ngrokregion="in";;
	*)
		echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Invalid Option, Tryagain"
		{ sleep 5; clear; banner; echo -e ""; ngrok_region; };;
	esac
}
start_ngrok() {
	echo -e "\n"
	ngrokregion="us"
    echo -e "${RED}[${WHITE}?${RED}]${ULWHITE}${BOLDWHITE}Change ngrok server region ${NA}"
    echo -e "   ${GREEN}Current region : ${BLUE}${ngrokregion}${NA}"
    echo -e ""
    echo -e "${BLUE}[1/Y]  ${CYAN} YES ${NC}"
    echo -e "${BLUE}[2/N/*]${CYAN} NO ${NC}"
    echo -e "${NC}"
    temprompt="$(echo -e "${YELLOW}>> ${BLUE}")"
	read -p "${temprompt}"
	case $REPLY in
	1 | Y | y | yes | Yes | YES)
		ngrok_region;;
	*)
		echo -e " ";;
	esac

        echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Launching Ngrok..."
        if [[ `command -v termux-chroot` ]]; then
                cd ${server_dir}
                termux-chroot ./ngrok http --region ${ngrokregion} "$HOST":"$PORT"> /dev/null 2>&1 &
        else
                cd ${server_dir}
                sleep 2 && ./ngrok http --region ${ngrokregion} "$HOST":"$PORT"> /dev/null 2>&1 &
        fi
	sleep 8
	fetchlink_ngrok
	checklink
}
fetchlink_ngrok() {
	ngrok_url=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -Eo '(https)://[^/"]+(.ngrok-free.app)')
        LINK="${ngrok_url}"
}
kill_ngrok(){
    if [[ `pidof ngrok` ]]; then
        killall ngrok > /dev/null 2>&1
    fi
}
## TUNNEL - Cloudflared
check_cloudflared(){
        { clear; banner; echo -e ""; }
	if [ ! -e "${server_dir}/cloudflared" ]; then
		echo -e " "
                echo -e "${GREEN}[${WHITE}!${GREEN}]${GREEN} CLOUDFLARED NOT INSTALLED!!${BLUE}"
                echo -e "${GREEN}[${WHITE}?${GREEN}]${ULWHITE}${BOLDWHITE} Do you want to install now? ${NF} : ${NC}"
                echo -e " " 
                echo -e "${BLUE}[1/Y]  ${CYAN} YES ${NC}"
                echo -e "${BLUE}[2/N/*]${CYAN} NO ${NC}"
                echo -e "${NC}"
		temprompt="$(echo -e "${YELLOW}>> ${BLUE}")"
                read -p "${temprompt}"
		case $REPLY in
		Y | y)
			install_cloudflared
			start_cloudflared;;
		N | n | *)
			tunnel_menu;;
		esac
	else
                start_cloudflared
	fi
}
install_cloudflared() {
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing Cloudflared...${NC}"
		arch=`uname -m`
		if [[ ("$arch" == *'arm'*) || ("$arch" == *'Android'*) ]]; then
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm' 'cloudflared'
		elif [[ "$arch" == *'aarch64'* ]]; then
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64' 'cloudflared'
		elif [[ "$arch" == *'x86_64'* ]]; then
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64' 'cloudflared'
		else
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-386' 'cloudflared'
		fi
}
start_cloudflared() {
        rm -rf ${server_dir}/.cld.log > /dev/null 2>&1 &
        echo -ne "\n\n${RED}[${WHITE}-${RED}]${GREEN} Launching Cloudflared..."

        if [[ `command -v termux-chroot` ]]; then
                cd ${server_dir}
                termux-chroot ./cloudflared tunnel -url "$HOST":"$PORT" --logfile .cld.log > /dev/null 2>&1 &
        else
                cd ${server_dir}
                sleep 2 && ./cloudflared tunnel -url "$HOST":"$PORT" --logfile .cld.log > /dev/null 2>&1 &
        fi
	sleep 8
	fetchlink_cloudflared
	checklink
}
fetchlink_cloudflared() {
	cldflr_url=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' "${server_dir}/.cld.log")
        LINK="${cldflr_url}"
}
kill_cloudflared(){
    if [[ `pidof cloudflared` ]]; then
        killall cloudflared > /dev/null 2>&1
    fi
}
## TUNNEL - LocalXpose
check_localxpose(){
	if [ ! -e "${server_dir}/loclx" ]; then
		echo -e " "
                echo -e "${GREEN}[${WHITE}!${GREEN}]${GREEN} LOCALXPOSE NOT INSTALLED!!${BLUE}"
                echo -e "${GREEN}[${WHITE}?${GREEN}]${ULWHITE}${BOLDWHITE} Do you want to install now? ${NF} : ${NC}"
                echo -e " " 
                echo -e "${BLUE}[1/Y]  ${CYAN} YES ${NC}"
                echo -e "${BLUE}[2/N/*]${CYAN} NO ${NC}"
                echo -e "${NC}"
		temprompt="$(echo -e "${YELLOW}>> ${BLUE}")"
                read -p "${temprompt}"
		case $REPLY in
		Y | y)
			install_localxpose
			loclx_token_setup
			start_loclx;;

		N | n | *)
			tunnel_menu;;

		esac
	else
		start_loclx
	fi
}
install_localxpose() {
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing LocalXpose...${NC}"
		arch=`uname -m`
		if [[ ("$arch" == *'arm'*) || ("$arch" == *'Android'*) ]]; then
			download 'https://api.localxpose.io/api/v2/downloads/loclx-linux-arm.zip' 'loclx'
		elif [[ "$arch" == *'aarch64'* ]]; then
			download 'https://api.localxpose.io/api/v2/downloads/loclx-linux-arm64.zip' 'loclx'
		elif [[ "$arch" == *'x86_64'* ]]; then
			download 'https://api.localxpose.io/api/v2/downloads/loclx-linux-amd64.zip' 'loclx'
		else
			download 'https://api.localxpose.io/api/v2/downloads/loclx-linux-386.zip' 'loclx'
		fi
}
loclx_token_check(){
        auth_f=".localxpose/.access" || auth_f="$HOME/.localxpose/.access"
        if [ -f "${HOME}/.localxpose/.access" ]; then
        echo -e "${RED}[${WHITE}?${RED}]${ULWHITE}${BOLDWHITE}Change LocalXpose authtoken ${NA}"
        echo -e "${BLUE}[1/Y]  ${CYAN} Setup new authtoken ${NC}"
        echo -e "${BLUE}[2/N/*]${CYAN} Use old authtoken ${NC}"
        echo -e "${NC}"
        temprompt="$(echo -e "${YELLOW}>> ${BLUE}")"
	    read -p "${temprompt}"
            case $REPLY in
            1 | Y | y | yes | Yes | YES)
                loclx_token_setup;;
            *)
                echo "";;
            esac
        else
                echo -e "\n${GREEN}[${WHITE}#${GREEN}]${BLUE} Setting up authtoken"
                loclx_token_setup
        fi
}
loclx_token_setup() {
	echo -e "\n\n${RED}[${WHITE}!${RED}]${GREEN} Create an account on ${YELLOW}localxpose.io${GREEN} & copy the token\n${NF}"
	sleep 3
    cd ${server_dir}
    ./loclx account login
    cd ${pro_dir}
}
start_loclx() {
	{ clear; banner; echo -e ""; }
    loclx_token_check
	echo -e "\n"
        temprompt="$(echo -e "${GREEN}[${WHITE}?${GREEN}]${ULWHITE}${BOLDWHITE} CHANGE LocalXpose SERVER REGION (Y/eu/us/N)${NA}${YELLOW}>> ${NA}")"
	read -n1 -p "${temprompt}" opinion
	[[ ${opinion,,} == "y" ]] && loclx_region="eu" || loclx_region="us"
	echo -e "\n\n${RED}[${WHITE}-${RED}]${GREEN} Launching LocalXpose..."

	if [[ `command -v termux-chroot` ]]; then
                cd ${server_dir}
                termux-chroot ./loclx tunnel --raw-mode http --region ${loclx_region} --https-redirect -t "$HOST":"$PORT" > ${server_dir}/.loclx  > /dev/null 2>&1 &
	else
		cd ${server_dir}
        ./loclx tunnel --raw-mode http --region ${loclx_region} --https-redirect -t "$HOST":"$PORT" > ${server_dir}/.loclx  > /dev/null 2>&1 &
	fi
	sleep 8
	fetchlink_localxpose
	checklink
}
fetchlink_localxpose() {
	loclx_url=$(cat ${server_dir}/.loclx | grep -o '[0-9a-zA-Z.]*.loclx.io')
        LINK="${loclx_url}"
}
kill_loclx(){
    if [[ `pidof loclx` ]]; then
        killall loclx > /dev/null 2>&1
    fi
}

#TUNNEL - Serveo.net
check_serveo() {
    { clear; banner; echo -e ""; }
	if [[ ! -d "${ssh_dir}"  && -z "$(ssh-keygen -F serveo.net)" ]]; then
		echo -e " "
        echo -e "${GREEN}[${WHITE}!${GREEN}]${GREEN} Serveo.net NOT INSTALLED!!${BLUE}"
        echo -e "${GREEN}[${WHITE}?${GREEN}]${ULWHITE}${BOLDWHITE} Do you want to install now? ${NF} : ${NC}"
        echo -e " " 
        echo -e "${BLUE}[1/Y]  ${CYAN} YES ${NC}"
        echo -e "${BLUE}[2/N/*]${CYAN} NO ${NC}"
        echo -e "${NC}"
        temprompt="$(echo -e "${YELLOW}>> ${BLUE}")"
        read -p "${temprompt}"
		case $REPLY in
            Y | y)
                install_serveo
                start_serveo;;
            N | n | *)
                tunnel_menu;;
		esac
	else
        start_serveo
	fi
}
install_serveo() {
    check_ssh
    echo -ne "\n${GREEN}[${WHITE}-${GREEN}]${YELLOW} Installing Serveo."
    if [ ! -d ${ssh_dir} ]; then
        mkdir -p "${ssh_dir}" && ssh-keygen -N '' -t rsa -f "${ssh_dir}/id_rsa"  > /dev/null 2>&1 &
    fi
    ssh-keyscan -H serveo.net >> ${ssh_dir}/known_hosts  > /dev/null 2>&1 &
    sleep 3
}
start_serveo(){
    setup_site_check
    rm -rf ${server_dir}/.serveo.log
    ssh -R 80:"$HOST":"$PORT" serveo.net -T -n >> "${server_dir}/.serveo.log" 2>&1 &
	sleep 8
	fetchlink_serveo
	checklink
}
fetchlink_serveo() {
    serveo_url=$(grep -o 'https://[-0-9a-z]*\.serveo.net' "${server_dir}/.serveo.log")
    LINK="${serveo_url}"
}

#Install SSH
check_ssh(){
    if [[ `command -v termux-chroot` ]]; then
        if pkg list-installed | grep -q "openssh"; then
            echo -ne "\n${GREEN}[${WHITE}-${GREEN}]${YELLOW}SSH is installed."
        else
            install_ssh
        fi
    else
        if which ssh &>/dev/null; then
            echo -ne "\n${RED}[${WHITE}-${RED}]${GREEN} SSH is installed."
        else
            install_ssh
        fi
    fi
}
install_ssh(){
    echo -ne "\n${RED}[${WHITE}-${RED}]${GREEN} Installing ssh."
    if [[ `command -v termux-chroot` ]]; then
        pkg install openssh  -y > /dev/null 2>&1 &
    elif command -v apt-get &>/dev/null; then
        sudo apt-get install -y openssh-client openssh-server > /dev/null 2>&1 &
    elif command -v yum &>/dev/null; then
        sudo yum install -y openssh-clients openssh-server > /dev/null 2>&1 &
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y openssh-clients openssh-server > /dev/null 2>&1 &
    elif command -v zypper &>/dev/null; then
        sudo zypper install -y openssh > /dev/null 2>&1 &
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm openssh > /dev/null 2>&1 &
    else
        echo "Unsupported package manager. Please install SSH manually."
        sleep 5
        msg_exit
    fi
    if [ ! -d ${ssh_dir} ]; then
        mkdir -p "${ssh_dir}" && ssh-keygen -N '' -t rsa -f "${ssh_dir}/id_rsa" > /dev/null 2>&1 &
    fi
}
# Download Binaries
download() {
	url="$1"
	output="$2"
	file=`basename $url`
	if [[ -e "$file" || -e "$output" ]]; then
		rm -rf "$file" "$output"
	fi
	curl --silent --insecure --fail --retry-connrefused \
		--retry 3 --retry-delay 2 --location --output "${file}" "${url}"

	if [[ -e "$file" ]]; then
		if [[ ${file#*.} == "zip" ]]; then
			unzip -qq $file > /dev/null 2>&1
			mv -f $output ${server_dir}/$output > /dev/null 2>&1
		elif [[ ${file#*.} == "tgz" ]]; then
			tar -zxf $file > /dev/null 2>&1
			mv -f $output ${server_dir}/$output > /dev/null 2>&1
		else
			mv -f $file ${server_dir}/$output > /dev/null 2>&1
		fi
		chmod +x ${server_dir}/$output > /dev/null 2>&1
		rm -rf "$file"
	else
		echo -e "\n${RED}[${WHITE}!${RED}]${RED} Error occured while downloading ${output}."
		{ reset_color; exit 1; }
	fi
}

#Host and port setup
HOST='127.0.0.1'
start_php() {
        { clear; banner; echo -e ""; }
        echo -ne "\n${RED}[${WHITE}-${RED}]${BLUE} Starting PHP server...${NC}"
        cd ${www_dir} && php -S "$HOST":"$PORT" > /dev/null 2>&1 &
}
kill_php(){
    if [[ `pidof php` ]]; then
        killall php > /dev/null 2>&1
    fi
}
cusport() {
        status_display
        PORT=4444
        echo -e "${RED}[${WHITE}?${RED}]${ULWHITE}${BOLDWHITE}DO YOU WANT TO SETUP CUSTOM PORT ${NA}"
        echo -e "   ${GREEN}Current port : ${BLUE}${PORT}${NA}"   
        echo -e ""
        echo -e "${BLUE}[1/Y]  ${CYAN} YES ${NC}"
        echo -e "${BLUE}[2/N/*]${CYAN} NO ${NC}"
        echo -e ""
        
        read -p "${prompt}"
	case $REPLY in
	1 | Y | y | yes | Yes | YES)
                echo -e ""
                echo -e ""
                temprompt="$(echo -e "${ULWHITE}${BOLDWHITE}TYPE YOUR CUSTOM PORT ${NA}${YELLOW}>> ${BLUE}")"
		read -p "${temprompt}" cport
		PORT="${cport}";;
	*)
		PORT="4444";;
	esac
}

#Check whether link was generated properly
checklink() {
	if [ -z "$LINK" ]; then
		clear
		banner
		echo -e " "
		echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Error in generating the link"
		echo -ne "\n${RED}[${WHITE}-${RED}]${GREEN} Starting localhost. You might need to start tunneler manually"
		sleep 5
        cd ${pro_dir}
		tunnel_name="LocalHost"
        tunnel_id="localhost"
		start_localhost
	else
        cd ${pro_dir}
        LINK = "${LINK}/index.php"
		cusurl
	fi
}

tunnel_menu