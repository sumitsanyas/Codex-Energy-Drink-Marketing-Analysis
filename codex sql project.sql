select * from fact_survey_responses
select * from dim_cities
select * from dim_repondents 

-- Demographic Insights
--1.Who prefers energy drink more? (male/female/non-binary?)

select gender ,COUNT(respondent_id) as Total_respondent from dim_repondents 
group by gender order by COUNT(respondent_id) desc

--2.Which age group prefers energy drinks more?

select  age as Age_group,COUNT(respondent_id) as Total_respondent from dim_repondents 
group by age order by COUNT(respondent_id) desc

--3.Which type of marketing reaches the most Youth (15-30)

select  marketing_channels ,COUNT(respondent_id) as Total_respondent from fact_survey_responses 
group by marketing_channels order by COUNT(respondent_id) desc

--Consumer Preferences
--4. What are the preferred ingredients of energy drinks among respondents?

select Ingredients_expected ,COUNT(respondent_id) as Total_respondent from fact_survey_responses 
group by Ingredients_expected order by COUNT(respondent_id) desc

--5.What packaging preferences do respondents have for energy drinks?

select Packaging_preference ,COUNT(respondent_id) as Total_respondent from fact_survey_responses 
group by Packaging_preference order by COUNT(respondent_id) desc

--Competition Analysis
--6. Who are the current market leaders?

select Current_brands ,row_number() over (order by COUNT(respondent_id) desc) as rank ,COUNT(respondent_id) as Total_respondent from fact_survey_responses 
group by Current_brands 

--7.What are the primary reasons consumers prefer those brands over ours?

select Reasons_for_choosing_brands ,COUNT(respondent_id) as Total_respondent from fact_survey_responses 
group by Reasons_for_choosing_brands order by COUNT(respondent_id) desc

 --Marketing Channels and Brand Awareness:
---8.Which marketing channel can be used to reach more customers?

select  dr.Age,fsr.marketing_channels ,COUNT(fsr.respondent_id) as Total_respondent from fact_survey_responses fsr 
join dim_repondents dr on fsr.Respondent_ID=dr.Respondent_ID
group by dr.Age,fsr.marketing_channels order by Total_respondent desc

--Brand Penetration:
--9.What do people think about our brand? (overall rating)?select taste_experience ,COUNT(respondent_id) as total_respondent from fact_survey_responsesgroup by Taste_experience order by total_respondent desc--Brand Penetration:codexselect Brand_perception as Brand_perception_codex ,COUNT(respondent_id) as total_respondent from fact_survey_responses where Current_brands ='codex'group by Brand_perception order by total_respondent desc--10.Which cities do we need to focus more on?
select  dc.Tier,dc.City,COUNT(dr.Respondent_ID) as Total_respondent from dim_repondents dr 
join dim_cities dc on dr.City_ID=dc.City_ID
group by dc.City,dc.Tier order by Total_respondent desc

--Purchase Behavior:
--11.Where do respondents prefer to purchase energy drinks?

select Purchase_location ,COUNT(respondent_id) as total_respondent from fact_survey_responses group by Purchase_location order by total_respondent desc

--12.What are the typical consumption situations for energy drinks among respondents?

select Typical_consumption_situations ,COUNT(respondent_id) as total_respondent from fact_survey_responses group by Typical_consumption_situations order by total_respondent desc

--13.What factors influence respondents' purchase decisions, such as price range and limited edition packaging?
select Price_range ,COUNT(respondent_id) as total_respondent from fact_survey_responses group by Price_range order by total_respondent desc

--Limited edition packaging 

select limited_edition_packaging,
COUNT(respondent_id) as total_respondent,casewhen Limited_edition_packaging =1 then 'yes'when Limited_edition_packaging = 0 then 'no'when Limited_edition_packaging is null then 'not_sure'end as care_about_editionfrom fact_survey_responses group by Limited_edition_packaging order by total_respondent desc

--Product Development
--14.Which area of business should we focus more on our product development? (Branding/taste/availability

--Branding
select Reasons_for_choosing_brands  as reason_to_choose_codex,COUNT(respondent_id) as total_respondent from fact_survey_responses where Current_brands='codex'group by Reasons_for_choosing_brands  order by total_respondent desc
--taste
select taste_experience as codex_taste ,COUNT(respondent_id) as total_respondent from fact_survey_responses where Current_brands='codex'group by Taste_experience order by total_respondent desc
--availability
select Reasons_preventing_trying  ,COUNT(respondent_id) as total_respondent from fact_survey_responses where Current_brands='codex'group by Reasons_preventing_trying order by total_respondent desc

--improvent_to_codex_by_respondent
select Improvements_desired  ,COUNT(respondent_id) as total_respondent from fact_survey_responses where Current_brands='codex'group by Improvements_desired order by total_respondent desc














