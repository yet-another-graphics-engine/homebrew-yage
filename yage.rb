class Yage < Formula
  desc "Yet another Graphics Engine is a graphics library based on Cairo / GTK+ 3"
  homepage "https://github.com/yet-another-graphics-engine/YaGE/"
  head "https://github.com/yet-another-graphics-engine/YaGE.git"

  # YaGE make uses of AVPlayer Objective-C class, which is only available on Lion and later.
  depends_on :macos => :lion
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "gtk+3"
  depends_on "gnome-icon-theme"
  depends_on "cairo"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <yage.h>

      int main()
      {
        yage_init(640, 480);
        yage_quit();
        return 0;
      }
    EOS
    args = %w[-lyage test.c -o test]
    system ENV.cc, *args
    system "./test"
  end
end
