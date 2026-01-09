function 2pdf
    if test (count $argv) -ne 1
        echo "Usage: 2pdf <file-or-directory>"
        return 1
    end

    set target $argv[1]

    if test -d $target
        for f in $target/*.{ppt,pptx,doc,docx,xls,xlsx,odt,odp,ods}
            if test -e $f
                echo "Converting $f"
                libreoffice --headless --convert-to pdf "$f"
            end
        end
        return
    end

    libreoffice --headless --convert-to pdf "$target"
end
