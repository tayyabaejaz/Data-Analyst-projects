 Select * FROM portfolio.`covid vaccinations`;
 Select* FROM portfolio.coviddeaths
 where continent is not null;
 
 -- SELECTING DATA TO BE USED
 SELECT Location,date,population,total_cases,new_cases,total_deaths
 FROM portfolio.coviddeaths  order by 1,2;
 
 -- looking at total cases vs total deaths
SELECT Location,date,population,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
 FROM portfolio.coviddeaths
 where location = 'Afghanistan'
 order by 1,2;
 
 -- Looking at the total cases vs population
 SELECT Location,date,population,total_cases,(total_cases/population)*100 as covidPercentage
 FROM portfolio.coviddeaths
 where location = 'Afghanistan'
 order by 1,2;
 
 
-- showing countries with higest deaths
SELECT location, max(total_deaths)as TotaldeathCount
FROM portfolio.coviddeaths
where continent is not null
Group by location
order by totaldeathCount desc;

-- looking at coutries with highest Infection rate
 SELECT Location,population,max(total_cases) as highestInfectionCount,(max(total_cases)/population)*100 as PErcentageinfected
 FROM portfolio.coviddeaths
 group by location,population
 order by 1,2;
 
 -- CONTINENT
  SELECT continent,population,max(total_cases) as highestInfectionCount,(max(total_cases)/population)*100 as PErcentageinfected
 FROM portfolio.coviddeaths
 group by continent,population
 order by 1,2;
 
-- this query will show continent with highest deathrate within continents
SELECT continent, max(total_deaths)as TotaldeathCount
FROM portfolio.coviddeaths
where continent is not null
Group by continent
order by totaldeathCount;

-- Global number 
SELECT date,SUM(new_cases) as total_cases,SUM(new_deaths) as total_deaths,(SUM(new_deaths)/SUM(new_cases))*100 as DeathPercentage
FROM portfolio.coviddeaths
where continent is not null
group by date
order by 1,2;

-- if we want to see total new cases without everyday description
SELECT SUM(new_cases) as total_cases,SUM(new_deaths) as total_deaths,(SUM(new_deaths)/SUM(new_cases))*100 as DeathPercentage
FROM portfolio.coviddeaths
where continent is not null
-- group by date
order by 1,2;

-- looking at total population vs vaccination
 Select dea.continent,dea.date,dea.population,vac.new_vaccinations,sum(vac.new_vaccinations)OVER (partition by dea.location order by dea.location,dea.date)
 FROM portfolio.coviddeaths dea
 JOIN portfolio.`covid vaccinations` vac
 ON dea.location=vac.locatione
 and dea.date=vac.date;

 