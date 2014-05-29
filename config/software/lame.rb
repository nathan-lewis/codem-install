name "lame"
default_version "3.99.5"

dependency "ncurses"

source :url => "http://downloads.sourceforge.net/project/lame/lame/3.99/lame-#{version}.tar.gz",
       :md5 => "84835b313d4a8b68f5349816d33e07ce"

relative_path "lame-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command "sudo apt-get -y install libmp3lame-dev" if platform == "ubuntu"

  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--enable-shared",
          ]
  command "make -j #{max_build_jobs}", :env => env
  command "make install", :env => env
end
