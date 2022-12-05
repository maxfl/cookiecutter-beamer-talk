$pdf_mode = 1;
$dvi_mode = $postscript_mode = 0;
$pdflatex = "pdflatex -file-line-error -interaction=nonstopmode -synctex=1 %O %S";
$pdflatex = "lualatex --file-line-error --interaction=nonstopmode --synctex=1 %O %S";
#$pdflatex = "pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S";

$clean_ext      .= ' %R.tdo %R.run.xml';
$clean_full_ext .= ' %R.bbl';
$clean_ext      .= ' %R.snm %R.nav';

#####################################################################################################
## Support glossaries package
## http://tex.stackexchange.com/questions/1226/how-to-make-latexmk-use-makeglossaries
##

# add a hook
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

# define a hook function
sub run_makeglossaries {
  if ( $silent ) {
    system "makeglossaries -q '$_[0]'";
  }
  else {
    system "makeglossaries '$_[0]'";
  };
}

# add extensions for cleaning
push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
push @generated_exts, 'tot';
$clean_ext .= ' %R.ist %R.xdy';
