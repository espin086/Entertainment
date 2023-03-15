if [ $1 = "--h" ]
then
	echo ""
    echo "************** HELP FILE **************"
    echo ""
    echo "Author: JJ Espinoza"
    echo "Description: Scrapes data from the web"
    echo ""
    echo "---------------------------------------"
    echo ""
    echo "Commands:                               Info:"
    echo "./2_pull_data.sh --h		        Help Menu"
    echo "./2_pull_data.sh --releases	Pulls data for future film releases"
    echo "./2_pull_data.sh --actors   Pulls data on actors films (num/box office)"
    echo "./2_pull_data.sh --box_current_month   Pulls box offie data to date"
        echo "./2_pull_data.sh --pushtogoogle   Pushes data to Google cloud storage"
    echo ""
    echo "Current Directory is: "
    pwd
    echo ""
    echo "---------------------------------------"

fi

if [ $1 = "--releases" ]
then
Rscript /Users/jje/Documents/00__mytools/3_mojo/1_src/2_r/1_future_release_dates.R
fi

if [ $1 = "--actors" ]
then
Rscript /Users/jje/Documents/00__mytools/3_mojo/1_src/2_r/2_actors.R
fi

if [ $1 = "--box_current_month" ]
then
Rscript /Users/jje/Documents/00__mytools/3_mojo/1_src/2_r/3_monthly_box.R
fi


