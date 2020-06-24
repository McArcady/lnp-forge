# Prevent failure of rpmbuild when mangling shebangs (I believe this is caused by https://bugzilla.redhat.com/show_bug.cgi?id=1541318, marked WONTFIX)
%undefine __brp_mangle_shebangs

Name:           linux-dwarf-pack
Version:        0.1
Release:        1%{?dist}
Summary:        McArcady's Lazy Newb Pack for Dwarf Fortress

License:        Multiple
URL:            https://github.com/McArcady/lnp-forge
BuildArch:      x86_64

BuildRequires:  gperf, qt5-qtbase-devel, ninja-build, qt5-qtdeclarative-devel, perl-IO-Compress, perl, perl-XML-LibXML, perl-XML-LibXSLT, mercurial, git, cmake, gcc-c++, zlib-devel, mesa-libGL-devel, ncurses-devel, gtk2-devel, dos2unix, texinfo, help2man
Requires:       SDL, SDL_image, SDL_ttf, openal-soft, alsa-lib, alsa-plugins-pulseaudio, mesa-dri-drivers, python, gnome-terminal, java-1.8.0-openjdk, python3-tkinter, qt5-qttools

%description
A ready-to-go rpm package of McArcady's Lazy Newb Pack for Dwarf Fortress

%build
./configure --prefix=$PWD && make install
./bin/lnp-forge build
cat > ./.build/src/lnp-0.14/PyLNP.user <<EOF
{
  "updateDays": 0, 
  "terminal": "nohup gnome-terminal -x", 
  "terminal_type": "Custom command", 
  "tkgui_height": 737, 
  "tkgui_width": 435
}
EOF

%install
mkdir -p %{buildroot}/%{_datadir}
cp -r ./.build/src/lnp-0.14 %{buildroot}/%{_datadir}/%{name}
# This could be applied more selectively but, at the moment, it works
chmod -R 777 %{buildroot}/%{_datadir}/%{name}
# See https://lists.fedoraproject.org/pipermail/packaging/2012-December/008792.html
find %buildroot -type f \( -name '*.so' -o -name '*.so.*' \) -exec chmod 755 {} +
mkdir -p %{buildroot}/%{_bindir}
ln -rs %{buildroot}/%{_datadir}/%{name}/startlnp.sh %{buildroot}/%{_bindir}/%{name}

%files
%{_bindir}/%{name}
"%{_datadir}/%{name}/"

%changelog
* Sat Jun 23 2020 Albert <github@albert.sh>
- 
