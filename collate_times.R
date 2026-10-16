library(dplyr)
library(readxl)
library(purrr)
library(stringr)

#### Define clean-up tables ####
#### Clean dept ####
clean_dept <- tribble(
  ~from,  ~to,
  c(
    "AM",
    "Adv  Man",
    "Adv Manu",
    "Adv manu",
    "Adv. Man",
    "Adv. Man.",
    "Advan Manu",
    "Advance Manu",
    "Advance manu"
  ), "Advanced manufacturing",

  c(
    "Bio Eng",
    "BioEng",
    "Bioeng",
    "Bioengineering"
  ), "Bioengineering",

    "CITRA", "CITRA",
    "Clinical Physics", "Clinical Physics",
    "E-Learning", "Training",

  c(
    "Annual Leave",
    "FLEXI",
    "Flex",
    "Leave",
    "Personal Leave"
  ), "Leave",
  
    "MP", "MP",
  c(
    "Management", "Management",
    "Meeting"
  ), "Bioengineering",
  
    "Redlux Scanning", "Redlux Scanning",
  "CITRA", "CITRA",
  "E-Learning", "Training",
  "Redlux Scanning", "Redlux"
)
  

# clean_action <- tribble(
#   ~from, ~to,
#   c("3D Models post processing", 
#     "3D model Post processing",
#     "3D model post processing",
#     "Post processing MJP / Formlabs",
#     "Post processing Objet",
#     "Post processing formlabs/mjp",
#     "Post processing peek",
#     "Post processing/ Head clean",
#     "Powder printer",
#     "Power Printer"
#   ), "3D models post-processing",
#   c("3D Printed components data clean up",
#     "3D printed  Hip/Knee",
#     "3D printed component Data clean up",
#     "3D printed components Data clean up",
#     "3D printed components data clean up"
#   ), "Project - 3D printed components",
#   c("3D Scanning", 
#     "Artec Scanning",
#     "Artec scanning training /pract",
#     "Artec scanning training witn EN",
#     "Artect Scanning"
#   ), "Scanning",
#   "Alval Patient calling",
#   "Annual Leave", "leave",
#   c("Bucket triage",
#     "Bucket triage with AK",
#     "Bucket triage/ post triage productions"
#   ), "Implant triage",
#   "C-pap mask",
#   "Card  printer set up",
#   "Ceramic project",
#   "Curtin FTIR",
#   "Cutting fem Comp",
#   "Cutting fem Comp & EDX",
#   "Data clean up",
#   "Data collation",
#   "Data collecting for PS study",
#   "Data put together",
#   "Data search",
#   "Database cleaning",
#   "Div Meeting", "Overhead",
#   "Emergency procedure", "Training",
#   "Etching",
#   "Etching Corin Liner",
#   "Etching Corin liner",
#   "Etching Photo Organising",
#   "Extra photography",
#   "Extra photography for reports",
#   "Extra photos",
#   "Ftir data collection",
#   "General Lab duties", "Housekeeping",
#   "General Retrievals", "Retrievals",
#   "General lab duties", "Housekeeping",
#   c("I'Ding",
#     "ID'ing",
#     "ID'ing Triathlon Insert styles",
#     "ID'ing/ Sorting CSSD",
#     "ID'ing/Archieving",
#     "IDing",
#     "Id'ing",
#     "Id'ing/ Archiving General",
#     "Iding"
#   ),
#   "Implant ID",
#   c("IVC",
#     "IVC 2 -7 year",
#     "IVC for FSH Report",
#     "IVC photos and Reports FSH"
#     ), "Project - IVC filters",
#   "Image sorting",
#   "Image/Data collation",
#   "Implant ID",
#   "Iprocurement ordering",
#   "Keliod scar post proccesing",
#   "Lab Tech report", "Reports",
#   "Lab organising/ stickers logs etc", "Housekeeping",
#   "Medacta poly data collation", "Project - Medacta UHMWPE",
#   "Meeting", "Overhead",
#   c("Met Prep",
#     "Met Prep/etching",
#     "Met prep etching"
#     ), "Mettalography",
#   "Microscope for Imogen", "Students",
#   c("Object Model Post process",
#   "Objet post processing",
#   "Objet roller bath clean"
#   ), "3D models post-processing",
#   "PEEK Project", "Project - PEEK Surface treatments",
#   "Packing implants",
#   c("Passivation",
#     "Passivation/pack",
#     "Patient card printing",
#     "Peek post processing/ Dispatch"
#     ), "PMMD service",
#   "Personal Leave", "Leave",
#   "Photo collation",
#   "Photo processing",
#   "Photography",
#   "Photos of  C-O-C hips for MP talk",
#   c("Photoshop",
#     "Photoshop Photography",
#     "Photoshop for reports",
#     "Photoshop reports",
#     "Photoshop, reports, close and archive",
#     "Photoshop/ CITRA reports",
#     "Photoshop/ Reports",
#     "Photoshop/Reports",
#     "Photoshop/reports"), 
#   "Reports",
#   "Poly prep", "UHMWPE investigations",
#   "Post processing", "3D models post-processing",
#   c("Procurement",
#   "Procuremtent"
#   ),  "Housekeeping",
#   c(
#   "Redlux",
#   "Redlux - Scanning",
#   "Redlux Scanning",
#   "Redlux analysis",
#   "Redlux scanning",
#   "Redlux- Scanning/analysis"
#   ), "Redlux Scanning",
#   "Report Photoshop", "Reports",
#   "Reports processing", "Reports",
#   "Rob meeting", "Overhead",
#   "S Roms", "Project - S-ROM Hips",
#   c(
#   "SEM",
#   "SEM Dual Mob",
#   "SEM Dual Mobility",
#   "SEM/ EDX",
#   "SEM/EDX",
#   "SEM/EDX/ReEtch"
#   ), "SEM",
#   c("SPT",
#   "SPT Data collation",
#   "SPT/ FTIR data collections"
#   ), "Small punch test",
#   "Sample packing UK", "Project - Lab comparison",
#   "Sample unpacking", "Project - Lab comparison",
#   "Scanning", "Scanning - which sort?",
#   "Sending  details to US", "Project - Lab comparison",
#   c("Smal Punch Test",
#   "Smal Punch Test-Data analysis",
#   "Small punch test"
#   ), "Small punch test",
#   "Sparking/training", "Training",
#   "Sparks", "Training",
#   "Stocktake / Ordering", "Housekeeping",
#   "Stocktake/ order", "Housekeeping",
#   "Student", "Students",
#   "Student  Lab Intro", "Students",
#   "Tabulating results", "Analysis - Project?",
#   "Travel to and from PCH",
#   c("Triage",
#     "Traige",
#     "Triage Implants",
#     "Triage buckets",
#     "TRIAGE"
#   ), "Implant triage",
#   "Triathlon Class. Data clean up",
#   "UKA and TKA  photos",
#   "Wear scar photography",
#   "White band photos",
#   "X ray dept bone",
#   "box to uk preperation", "Project - Lab comparison",
#   "e leaninhg", "Training",
#   "e learning", "Training",
#   "labels",
#   "personal leave", "Leave",
#   "stock take lab", "Housekeeping",
#   "tech time report", "Overhead"
# )

#### Read data ####

files <- list.files(here::here("data"), pattern = "*.xls?", full.names = TRUE)

path <- files[[2]]

read_tech_times <- function(path) {
  path |>
    excel_sheets() |>
    set_names() |>
    map(\(x) read_excel(path = path, 
                        sheet = x, 
                        col_types = "text",
                        na = c("", "NA", "N/A")
                        )
        ) |>
    list_rbind(names_to = "who") |>
    rename(proportion = `% break down`) |>
    rename_with(tolower) |>
    tidyr::drop_na(proportion) |> 
    mutate(date = janitor::excel_numeric_to_date(as.numeric(date))) |>
   tidyr::fill(everything())
}

times <- map(files, \(p) read_tech_times(p)) |> 
  setNames(basename(files)) |> 
  list_rbind(names_to = "file")

# Clean up variant spellings etc.
# 
times <- times |> 
  mutate(who = replace_values(who, "Sev" ~ "Sevda")) |>
  mutate(proportion = as.numeric(proportion)) |>
  mutate(dept = ifelse(is.na(dept) & str_detect(action, "(?i)leave"),
                       "Leave",
                       dept)
         )

clean_string <- function(s) {
  s |> tolower() |> str_squish() |> str_remove_all("\\.")
}

times |>
  mutate(dept_lc = clean_string(dept),
         action_lc = clean_string(action)
         ) |> 
  distinct(who, action_lc) |> 
  arrange(who, action_lc)  |> 
  print(n=Inf)

# Check that each day sums to 100%
times |> 
  summarise(total = sum(proportion), .by = c(who, date)) |> 
  filter(round(total) != 1)

# Use this to generate strings for cleaning
# 
# dept_strings <- times |> distinct(dept) |>
#   arrange(dept) |>
#   glue::glue_data('"{dept}", ') |>
#   glue::glue_collapse(sep = '\n  ')
# 
# glue::glue("clean_dept <- tribble(
#   ~from,  ~to,
#   {dept_strings}
# )"
# )


# Reduce and regularlise dept to smaller set
  
times <- times |>
  mutate(clean_dept =
           replace_values(dept, from = clean_dept$from, to = clean_dept$to)
  )

# Fix some errors that this misses
times <- times |>
  mutate(clean_dept = if_else(who == "Eddie" & 
                                str_detect(action, "report$|Rob meeting"),
                              "Management", 
                              clean_dept),
         
  )

# Who is doing what (roughly)
times |> 
  summarise(total = sum(proportion), .by = c(who, clean_dept)) |> 
  arrange(who, desc(total)) |>
  tidyr::pivot_wider(names_from = who, values_from = total)
