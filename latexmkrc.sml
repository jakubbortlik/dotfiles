# always create a pdf
$pdf_mode = 1;

# how pdflatex will be executed
$pdflatex = 'xelatex -interaction=nonstopmode -file-line-error-style $*';

$pdf_previewer = '';
$pdf_update_method = 0;
