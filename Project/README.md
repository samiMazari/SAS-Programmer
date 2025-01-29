# Tourism-SAS
In this case study, my role is to organize and prepare data for my company. Once I've prepared the data, the analysts and my team will use it to create reports, visualizations, and statistical models aimed at increasing our company's market share. For my latest project, I have a list of requirements and two data tables to work with. My task is to prepare the data so that my team can analyze inbound and outbound tourism for countries and continents in 2014. Based on the requirements, I can break my work down into three main tasks, each corresponding to a specific table I need to deliver: the `cleaned_tourism` table, the `final_tourism` table, and the `nocountryfound` table. Here's a high-level overview of each task.

### Task 1: Create the `cleaned_tourism` Table
My first task involves restructuring the original `tourism` table to meet specific data requirements. The current structure of the `tourism` table is not suitable for analysis because it contains mixed types of information in the `country` column. For example, this column holds not only country names but also details about tourism types (inbound or outbound), categories (such as the number of arrivals, departures, or expenditures), and other information. To make this table useful for analysis, I need to clean and restructure it. This involves organizing the data so that each type of information is stored in its appropriate column.

### Task 2: Create the `final_tourism` Table
After restructuring the `tourism` table, my second task is to merge it with the `country_info` table to create the `final_tourism` table. This new table will only contain rows where there is a match between the `country` columns in both tables. The `country_info` table has two columns: `continent` (which assigns an ID to each continent) and `country` (which lists the names of the countries). By merging these tables, I ensure that each row in the `final_tourism` table has complete information, including the continent to which each country belongs.

### Task 3: Create the `nocountryfound` Table
The third task is to identify any countries in the `tourism` table that do not have matching rows in the `country_info` table. For these unmatched countries, I need to create a `nocountryfound` table that contains a distinct list of such countries. This will help us identify any discrepancies or gaps in the data.

### Data Details
The `tourism` table consists of 23 columns and over 2,400 rows. Each row contains information like a numeric ID (when a country name appears in the `country` column), tourism type, and categories such as arrivals, departures, or expenditures in US dollars. The `series` column indicates the data collection method, but this is not the focus for this project. Columns labeled `_1995` through `_2014` contain numeric data stored as text, representing values in millions of US dollars for expenditure data or in thousands for passenger counts. For example, a scaled value of 21,719 in the `arrivals` column represents 21,719,000 passengers, calculated by multiplying the value by 1,000.

The `country_info` table includes two columns and 250 rows, with a `continent` ID for each continent and the corresponding `country` name. For example, "1" represents North America, "2" South America, and so on.

By following these tasks, I aim to produce clean and structured data tables that my team can easily analyze for insights into 2014 tourism trends.
