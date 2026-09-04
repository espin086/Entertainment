# Entertainment

Data science experiments on the media and entertainment industry, written mostly in R with a
smaller Python component. The code scrapes Box Office Mojo for actor grosses, film metadata,
release schedules and monthly box office, pulls historical stock prices for the major studios,
and builds text corpora from movie screenplays and rap lyrics. On top of that data it runs
clustering, logistic regression and caret-trained classifiers, plus a set of production
economics scripts that estimate Cobb-Douglas cost functions on film production inputs. This is
research and coursework code from around 2015 to 2017, organized as a pipeline of numbered
folders rather than as a packaged library. Several scrapers point at Box Office Mojo URLs that
no longer exist in that form, and several scripts hardcode absolute paths under
`~/Documents/HollywoodModels`, so expect to edit paths before anything runs.

## Catalog

| Folder | What it does | Main libs | Data used |
|---|---|---|---|
| `0. Data/0. Data Collection Code/0. Box Office Mojo Scrapers/` | Three R scrapers: actor totals by page, per-film metadata tables, and distributor release schedules for Buena Vista, Fox, Paramount, Sony, Universal and Warner Bros. Cleans dollar/percent formatting and derives year, month, week and weekday from release dates. | `XML`, `lubridate`, `rattle` | boxofficemojo.com HTML tables |
| `0. Data/1. Raw Data /0. TV Scripts - 2011-2015/` | Screenplay text files split into two labeled classes, `0. Blockbuster (75M+)` and `0. Not Blockbuster (<75M)`. Ships a bundled `xpdfbin-mac-3.04` copy, presumably to convert screenplay PDFs to text. | none (data) | ~80 screenplay `.txt` files |
| `0. Data/1. Raw Data /1. Top 100 Rap Songs on Billboard/` | Lyrics text files for songs from Billboard's Hot Rap Songs 25th anniversary top 100. | none (data) | ~24 lyric `.txt` files |
| `0. Data/1. Raw Data /` (root) | `EntertainmentStockPrices.csv` and `Movies - IMBD - ggplot2.csv`, the two tabular raw inputs. | none (data) | CSV |
| `0. Data/2. Clean Data/` | Cleaned outputs: IMDB movie table, future film release dates, k-means clustering of box office decay, and `TDM_Scripts.csv`, the term-document matrix built from the screenplays. | none (data) | CSV |
| `2. Descriptive Analytics/How many groups of actors are there?/` | Scales actor box office features, runs the within-sum-of-squares elbow method over k = 2..10, then k-means clusters actors by gross, film count and average per film. | base R `kmeans` | scraped actor table |
| `2. Descriptive Analytics/Exploring Future Film Release Dates/` | Saved plots for the release-date exploration (correlation, day-of-week distribution, timing area chart, distributor mix, cluster count) plus the `.rattle` project file. | `rattle` | future release dates |
| `2. Descriptive Analytics/Predicting Studio Stock price/` | Saved PNG charts of studio price series and the fitted GLM up-probability per ticker. | plots only | studio stock series |
| `3. Predictive Analytics/0. Predicting Major Film Studio Stock Prices/` | Downloads adjusted close for DIS, CMCSA, TWX, SNE, FOXA and VIAB from 2012 onward, cleans the series, then loops over tickers fitting logistic regression on a 70/30 time split to predict next-move direction and prints the confusion table and accuracy. | `zoo`, `tseries`, `glm` | Yahoo-style quote history |
| `3. Predictive Analytics/1. Prediction with Scripts/` | Builds a `tm` corpus from the two screenplay class folders, strips punctuation, whitespace, case and English stopwords, generates a term-document matrix, then trains caret models with repeated 7-fold CV (10 repeats) to classify blockbuster vs not. `Clean - Scripts - (Broken Code).R` is marked broken by the author. | `tm`, `plyr`, `class`, `reshape`, `caret`, `doMC` | screenplay corpus, `TDM_Scripts.csv` |
| `3. Predictive Analytics/2. Ranking My Thesis Among Rap Hits/` | Data cleaning pass over the Billboard rap lyrics corpus, aimed at scoring the author's thesis text against hit lyrics. Cleaning only; no model in the repo. | `XML` | rap lyrics corpus |
| `3. Predictive Analytics/3. Predicting IMBD Rating/` | Feature engineering on the IMDB ggplot2 movie table targeting `rating`, sourcing a `prep.data` helper from a separate local `my-toolbox` repo that is not included here. | base R, external toolbox | `Movies - IMBD - ggplot2.csv` |
| `4. Prescriptive Analytics/0. Production Economics/` | Six R scripts working through production economics on film inputs: production functions, then Cobb-Douglas cost function estimation, homogeneity tests, optimal cost shares, conditional demand elasticities, and marginal/average/total cost. Starts from the `appleProdFr86` sample dataset, then applies the same machinery to film cost data with props, director and actor input prices. The same five scripts also sit duplicated at the folder root. | `micEcon`, `miscTools`, `car`, `reshape` | `appleProdFr86`, film cost data |
| `scriphunter/` | A later restart of the box office work as a numbered CLI pipeline. `1_src/1_shell/` holds bash wrappers with `--h` help menus for directory scaffolding, git operations, and data pulls; `1_src/2_r/` holds the R scrapers those wrappers call plus a `0_summarize_csv.R` profiler with `--glance/--uni/--cor/--frq/--mis` modes; `1_src/2_python/` holds a Wikipedia and BeautifulSoup scraper for film pages along with ~130 scraped film `.txt` files. Shell scripts 3 through 8 (exploratory analysis, train, evaluate, deploy, predict, monitor) are empty placeholders, and the Python train/evaluate/deploy/predict/monitor scripts are help-menu stubs only. | `XML`, `lubridate`, `requests`, `BeautifulSoup`, `wikipedia`, `nltk` | `2_data/1_raw/*.csv`, scraped wiki text |
| `Clustering of Actors.Rpres` / `.md` | An R Presentation slide deck on the actor clustering work. Mostly still the RStudio template, with `summary(cars)` and `plot(cars)` placeholder slides. | `knitr` | none |
| `1. Data Processing/` | Empty apart from a `.DS_Store`. | none | none |

## Requirements

- R 3.x or later. Packages used across the scripts: `XML`, `lubridate`, `rattle`, `zoo`,
  `tseries`, `tm`, `plyr`, `class`, `reshape`, `caret`, `doMC`, `micEcon`, `miscTools`, `car`.
- Python 2.7 for `scriphunter/1_src/2_python/` (the scripts use `print` statements, not the
  function). Packages: `requests`, `beautifulsoup4`, `wikipedia`, `nltk`.
- Bash, for the `scriphunter` shell wrappers.
- `doMC` uses 4 cores and is not available on Windows.

## Installation

```bash
git clone https://github.com/espin086/Entertainment.git
cd Entertainment
```

R packages:

```r
install.packages(c("XML", "lubridate", "rattle", "zoo", "tseries", "tm", "plyr",
                   "class", "reshape", "caret", "doMC", "micEcon", "miscTools", "car"))
```

Python packages:

```bash
pip install requests beautifulsoup4 wikipedia nltk
```

Then fix the hardcoded paths. `3. Predictive Analytics/1. Prediction with Scripts/1. Data Cleaning.R`
points at `/Users/jjespinoza/Documents/HollywoodModels/...`, the `scriphunter` shell wrappers
point at `/Users/jje/Documents/00__mytools/...`, and the IMDB feature engineering script sources
a file from a separate `my-toolbox` repo. Update those to your own checkout before running.

## Usage

Scrape actor box office totals and cluster them:

```bash
Rscript "0. Data/0. Data Collection Code/0. Box Office Mojo Scrapers/Scaper-BOM-Actors.R"
Rscript "2. Descriptive Analytics/How many groups of actors are there?/1. Clustering of Actors by Salary.R"
```

Pull and model studio stock prices (run in order, the later scripts expect objects from the earlier ones):

```bash
cd "3. Predictive Analytics/0. Predicting Major Film Studio Stock Prices"
Rscript "0. Import - All Entertainment Stocks.R"
Rscript "1. Clean - All Entertainment Stocks.R"
Rscript "2. Explore - All Entertainment Stocks.R"
Rscript "3. Advanced Modeling - All Entertainment Stocks.R"
```

Build the screenplay term-document matrix and train the blockbuster classifier:

```bash
cd "3. Predictive Analytics/1. Prediction with Scripts"
Rscript "1. Data Cleaning.R"
Rscript "2.Machine Learning Models.R"
```

Work through the production economics scripts in numeric order:

```bash
cd "4. Prescriptive Analytics/0. Production Economics"
Rscript "0. Introduction to Production Economics.R"
Rscript "1. Production Functions.R"
```

scriphunter CLI:

```bash
cd scriphunter/1_src/1_shell
./2_datapipes.sh --h                  # help menu
./2_datapipes.sh --releases           # future film release dates
./2_datapipes.sh --actors             # actor box office totals
./2_datapipes.sh --box_current_month  # current-month box office

Rscript ../2_r/0_summarize_csv.R --glance ../../2_data/1_raw/2_actors.csv out.txt
python ../2_python/2_pull_data.py --wikisearch "Blade Runner 2049"
```

Note that `2_datapipes.sh` calls the R scripts by absolute path under `/Users/jje/`, so edit
those lines first.

## License

No LICENSE file in this repository.
