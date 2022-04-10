## code to prepare `my_dataset` dataset goes here

usethis::use_data(df_abs_con, df_creatinine_con, df_related_con,
                  df_joint_weight,
                  l_sample, l_exprs, name_libraries,
                  vec_type_choices,
                  overwrite = TRUE, internal = TRUE)
# so the internal is true or false? see ?use_data.
# how to document the data.

# Saving 'df_abs_con', 'df_creatinine_con', 'df_related_con', 'df_joint_weight',
# 'l_sample', 'l_exprs', 'name_libraries', 'vec_type_choices' to 'R/sysdata.rda'


