cp ./files_to_download/fish_prompt.fish ~/.config/fish/functions
cp ./files_to_download/ls.fish ~/.config/fish/functions
cp ./files_to_download/AMBUSH.jpg ~/Pictures
cp ./files_to_download/ghost_in_the_shell.jpg ~/Pictures
cp ./files_to_download/neon_skeleton.jp ~/Pictures

echo "Installing homebrew packages..."
brew install eza
brew install fontconfig
brew install openjdk
brew install rclone
brew install krb5

echo "installing flatpaks..."
flatpak install --noninteractive com.bitwarden.desktop
flatpak install --noninteractive com.github.tchx84.Flatseal
flatpak install --noninteractive com.github.wwmm.easyeffects
flatpak install --noninteractive com.github.zocker_160.SyncThingy
flatpak install --noninteractive com.moonlight_stream.Moonlight
flatpak install --noninteractive com.obsproject.Studio
flatpak install --noninteractive com.spotify.Client
flatpak install --noninteractive com.valvesoftware.Steam
flatpak install --noninteractive dev.vencord.Vesktop
flatpak install --noninteractive im.riot.Riot
flatpak install --noninteractive io.github.dvlv.boxbuddyrs
flatpak install --noninteractive io.github.flattool.Warehouse
flatpak install --noninteractive io.github.getnf.embellish
flatpak install --noninteractive io.github.input_leap.input-leap
flatpak install --noninteractive io.github.pwr_solaar.solaar
flatpak install --noninteractive io.github.trigg.discover_overlay
flatpak install --noninteractive io.gpt4all.gpt4all
flatpak install --noninteractive io.missioncenter.MissionCenter
flatpak install --noninteractive io.podman_desktop.PodmanDesktop
flatpak install --noninteractive it.mijorus.gearlever
flatpak install --noninteractive md.obsidian.Obsidian
flatpak install --noninteractive org.fedoraproject.MediaWriter
flatpak install --noninteractive org.fkoehler.KTailctl
flatpak install --noninteractive org.freedesktop.LinuxAudio.Plugins.Calf
flatpak install --noninteractive org.freedesktop.LinuxAudio.Plugins.LSP
flatpak install --noninteractive org.freedesktop.LinuxAudio.Plugins.MDA
flatpak install --noninteractive org.freedesktop.LinuxAudio.Plugins.TAP
flatpak install --noninteractive org.freedesktop.LinuxAudio.Plugins.ZamPlugins
flatpak install --noninteractive org.freedesktop.LinuxAudio.Plugins.swh
flatpak install --noninteractive org.freedesktop.Platform
flatpak install --noninteractive org.freedesktop.Platform
flatpak install --noninteractive org.freedesktop.Platform.Compat.i386
flatpak install --noninteractive org.freedesktop.Platform.GL.default
flatpak install --noninteractive org.freedesktop.Platform.GL.default
flatpak install --noninteractive org.freedesktop.Platform.GL.default
flatpak install --noninteractive org.freedesktop.Platform.GL.default
flatpak install --noninteractive org.freedesktop.Platform.GL32.default
flatpak install --noninteractive org.freedesktop.Platform.GL32.default
flatpak install --noninteractive org.freedesktop.Platform.ffmpeg-full
flatpak install --noninteractive org.freedesktop.Platform.openh264
flatpak install --noninteractive org.freedesktop.Platform.openh264
flatpak install --noninteractive org.gnome.DejaDup
flatpak install --noninteractive org.gnome.Platform
flatpak install --noninteractive org.gnome.Platform
flatpak install --noninteractive org.gnome.Platform
flatpak install --noninteractive org.gnome.World.PikaBackup
flatpak install --noninteractive org.gtk.Gtk3theme.Breeze
flatpak install --noninteractive org.gustavoperedo.FontDownloader
flatpak install --noninteractive org.kde.KStyle.Adwaita
flatpak install --noninteractive org.kde.KStyle.Adwaita
flatpak install --noninteractive org.kde.KStyle.Adwaita
flatpak install --noninteractive org.kde.Platform
flatpak install --noninteractive org.kde.Platform
flatpak install --noninteractive org.kde.Platform
flatpak install --noninteractive org.kde.Platform
flatpak install --noninteractive org.kde.gwenview
flatpak install --noninteractive org.kde.haruna
flatpak install --noninteractive org.kde.itinerary
flatpak install --noninteractive org.kde.kcalc
flatpak install --noninteractive org.kde.kclock
flatpak install --noninteractive org.kde.kdenlive
flatpak install --noninteractive org.kde.kontact
flatpak install --noninteractive org.kde.krdc
flatpak install --noninteractive org.kde.kweather
flatpak install --noninteractive org.kde.okular
flatpak install --noninteractive org.mozilla.Thunderbird
flatpak install --noninteractive org.mozilla.firefox
flatpak install --noninteractive org.rncbc.qpwgraph
flatpak install --noninteractive sa.sy.bluerecorder

mkdir ~/syncs
echo please setup sync thing before continueing...
echo press enter when ready.
read -l

echo creating distroboxes...
distrobox create --image archlinux --name main --volume ~/syncs/tools/:/tools:rw --init
distrobox enter -nw main -- sudo pacman -S --noconfirm --needed rustup git base-devel
distrobox enter -nw main -- rustup install stable
mkdir ~/git_projects
mkdir ~/git_projects/stardust
cd ~/git_projects
git clone https://aur.archlinux.org/yay-bin
cd yay-bin
distrobox enter main -- makepkg -si
cd ~ 
distrobox enter main -- yay -S --noconfirm --needed nano git pipewire pipewire-audio pipewire-jack pipewire-pules pipewire-session-manager mesa vulkan-icd-loader vulkan-intel vulkan-radeon fontconfig fish gcc gcc-libs keyutils vscodium-bin wayland wireplumber xcd-proto xcb-util-keysyms xkeyboard-config xorg-xauth xorg-xprop xorgproto eza

cd ~/git_projects/stardust
git clone -b dev https://github.com/StardustXR/server.git
git clone -b dev https://github.com/StardustXR/flatland.git
git clone -b dev https://github.com/StardustXR/protostar.git
git clone -b dev https://github.com/StardustXR/non-spatial-input.git

cd server
distrobox enter main -- cargo build --release
cd ..
cd flatland
distrobox enter main -- cargo build --release
cd ..
cd protostar/hexagon_launcher
distrobox enter main -- cargo build --release
cd ../..
cd non-spatial-input/manifold
distrobox enter main -- cargo build --release
cd ../simular
cargo build --release
cd ~/

distrobox create --root --image archlinux --name atarchbox --volume /var/home/pyro/syncs/tools/:/tools:rw --init
cd ~/git_projects/yay-bin
distrobox enter --root atarchbox -- sudo pacman -S nano git base-devel
distrobox enter --root atarchbox -- makepkg -si
distrobox enter --root atarchbox -- curl https://blackarch.org/strap.sh | sudo bash
disttobox enter --root atarchbox -- sudo rm /etc/pacman.d/blackar-mirrorlist
distrobox enter --root atarchbox -- sudo ln -sf /tools/blackarch-mirrorlist /etc/pacman.d/blackarch-mirrorlist
distrobox enter --root atarchbox -- for package in $(cat /tools/packages.txt); yay -S --needed --noconfirm $package end

echo "will you use this machine for work?"
set work_confirm read -l
if strings.match --ignore-case $work_confirm 'y'
    echo "please enter the webdav path to your work folder"
    set work_folder_path = read -l
    echo "please enter the webdav path to your work notes, starting at the account name, not the server"
    set work_notes = read -l
    mkdir ~/syncs/work_folder
    mkdir ~/syncs/work_notes
    echo "please enter the rclone entry for your taildrive"
    set tail_drive read -l 
    echo "function work_drive
    rclone mount $tail_drive:/$work_notes /var$HOME/syncs/work_notes/ --vfs-cache-mode writes --daemon
    sudo mount -t davfs -o uid=pyro -o gid=pyro $work_folder /var$HOME/syncs/work_folder/
end" > ~/.config/fish/functions/work_drive.fish
    echo "function dework
    sudo umount /var$HOME/syncs/work_folder
    sudo umount /var$HOME/syncs/work_notes
end" > ~/.config/fish/functions/dework.fish 
end

echo easy parts are done! setting up the additional overlay packags...
sudo rpm-ostree install wivrn
sudo rpm-ostree install davfs2

echo "you'll need to reboot to fully be setup, but you should be good to go now!"
