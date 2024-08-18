# HISTOGRAM OF THEOLOGICAL IDENTIFICATION ITEM

@fig-theology depicts the results of the item asking participants their current theological identification. According this plot, most of the sample are moderate in their theological views. Very few report being "Very Liberal" or "Very Conservative".

```{r}
#| label: fig-theology
#| fig-cap: "Current Theological Identification"
#| fig-align: left
#| fig-cap-location: top
#| echo: false
#| verbose: false
#| message: false
#| warning: false

source("code/Theology-Item.R")
# 3. Barplot
par(mar=c(5,10,5,5))
barplot(height=theo,
        names=c("1 - Very conservative","2","3","4 - In the middle","5","6","7 - Very liberal"),
        col="red",
        axisnames = TRUE,
        xlab="Percent of Sample",
        xlim=c(0,25),
        horiz=T, las=1)

```