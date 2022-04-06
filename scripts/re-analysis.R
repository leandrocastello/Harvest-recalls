library(tidyverse)
library(nlme)
library(lme4)
library(gamm4)
library(MuMIn)

dat <- readRDS("data/dat_typ.rds")$data %>%
  mutate(cpue_diff = cpue_fisher - cpue_sci,
         cpue_diff_per = 100 * ((cpue_fisher - cpue_sci) / cpue_sci)) %>%
  filter(!(f.name %in% c("cananeia_emalhe_tainha", "cananeia_emalhe_pescada"))) %>%
  mutate(s.fisherz = )
  #filter(cpue_diff_per < 600) 

hist(dat$cpue_diff_per, breaks = 30)


m1 <- lme(cpue_diff_per ~ s.fisher.agez * yearz, 
          random = list(f.name = ~ 1, id = ~ 1),
          data = dat, weights = varFixed(~cpue_diff_per),
          method = "ML")

m1 <- gamm(cpue_diff_per ~ s(s.fisher.agez, yearz), 
          random = list(f.name = ~ 1, id = ~ 1),
          data = dat, weights = varFixed(~cpue_diff_per),
          method = "ML")

msel <- dredge(m1)

mavg <- model.avg(msel)

fit <- fitted(m1)
res <- resid(m1)

plot(fit, res, xlab = "Fitted", ylab = "Residuals")

qqnorm(res)
qqline(res)



# Spatial effects controling by elevation ----

new_dat <- distinct(select(dat, s.fisher.agez, yearz)) %>%
  mutate(lon = zlon * sd(ls_lakes_summer$lon) + mean(ls_lakes_summer$lon),
         lat = zlat * sd(ls_lakes_summer$lat) + mean(ls_lakes_summer$lat),
         ele = zele * sd(ls_lakes_summer$ele) + mean(ls_lakes_summer$ele))

new_spl$fit <- predict(avgm, newdata = new_spl,
                       exclude = "s(lake_id)",
                       newdata.guaranteed = TRUE)


int_spl <- with(new_spl, interp::interp(x = lon, y = lat, z = fit))

fit_spl <- subset(data.frame(lon = rep(int_tmp$x, nrow(int_tmp$z)),
                             lat = rep(int_tmp$y, each = ncol(int_tmp$z)),
                             fit = as.numeric(int_tmp$z)), 
                  !is.na(fit)) %>%
  mutate(pef = fit - mu_sswt)

ggplot(fit_spl, aes(x = lon, y = lat, z = pef)) +
  geom_contour_filled(breaks = -6:2) +
  geom_contour(colour = "white") +
  geom_dl(aes(label=..level..), method = "top.pieces", 
          stat = "contour", breaks = -6:2) +
  scale_fill_brewer(palette = "RdYlBu", direction = -1) +
  xlab("Longitude") +
  ylab("Latitude") +
  theme_bw() +
  guides(fill = guide_legend(title = "Partial Effects Interval (°C)",
                             title.position = "top",
                             title.hjust = 0.5)) +
  theme(title = element_text(size = 14), legend.position = "top",
        strip.text = element_text(size = 12),
        axis.title.y = element_text(size = 14, margin = margin(0, 16, 0, 0)),
        axis.title.x = element_text(size = 14, margin = margin(16, 0, 0, 0)),
        axis.text = element_text(size = 12),
        legend.text = element_text(size = 12),
        panel.grid.major = element_blank())
