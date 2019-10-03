# Run once if necessary:
#
# install.packages(c("tidyverse", "jsonlite", "writexl"))

library(tidyverse)
library(jsonlite)
library(writexl)

# Read in with `simplifyVector = TRUE`, this flattens as much
# as possible
json <- read_json("Todos Registros.json", simplifyVector = TRUE)

# Review structure
names(json)
str(json)

# json$value is a data frame! Convert to a tibble for nicer output.
# See ?tibble or https://tibble.tidyverse.org for more info.
data <- as_tibble(json$value)
data


# Elementary statistics
data %>%
  count(UfPessoaNacional)

data %>%
  count(MoedaOperacao) %>%
  arrange(-n)

data %>%
  count(Ano)

data %>%
  filter(UfPessoaNacional != "", MoedaOperacao == "EUR") %>%
  count(Ano)

data %>%
  filter(UfPessoaNacional != "", MoedaOperacao == "EUR") %>%
  count(UfPessoaNacional)

data %>%
  filter(UfPessoaNacional != "", MoedaOperacao == "EUR") %>%
  count(UfPessoaNacional)

# Exploratory plot
data %>%
  filter(UfPessoaNacional != "", MoedaOperacao == "EUR") %>%
  ggplot(aes(x = UfPessoaNacional, y = ValorOperacao)) +
  scale_y_log10() +
  geom_boxplot()

# Save the data as Excel
writexl::write_xlsx(data, "data.xlsx")
