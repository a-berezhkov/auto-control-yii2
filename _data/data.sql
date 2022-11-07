-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Ноя 07 2022 г., 16:03
-- Версия сервера: 10.8.4-MariaDB
-- Версия PHP: 8.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `avto`
--

-- --------------------------------------------------------

--
-- Структура таблицы `avto_changelog`
--

CREATE TABLE `avto_changelog` (
  `id` int(11) NOT NULL,
  `avto_id` int(11) NOT NULL,
  `type` enum('fuel','sto','details') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `avto_mark`
--

CREATE TABLE `avto_mark` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `avto_model`
--

CREATE TABLE `avto_model` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avto_mark_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `car`
--

CREATE TABLE `car` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Свое название ',
  `year` year(4) DEFAULT NULL COMMENT 'Год выпуска',
  `fuel` enum('Бензин','Дизель','Газ','Газ+бензин','Электричество') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Тип топлива',
  `start_mileage` int(11) DEFAULT NULL COMMENT 'Начальный пробег',
  `fuel_volume` int(11) DEFAULT NULL COMMENT 'Объем бака, л.',
  `engine_type` enum('Бензин','Дизель','Газ','Гибрид','Электричество') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Тип двигателя',
  `transmission_type` enum('МКПП','АКПП','Роботизированная','Вариаторная') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Тип трансмиссии',
  `engine_volume` float DEFAULT NULL COMMENT 'Объем двигателя',
  `power` int(11) DEFAULT NULL COMMENT 'Мощность, л.с.',
  `vin` varchar(17) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'VIN номер',
  `avto_model_id` int(11) NOT NULL COMMENT 'Модель',
  `odometer` enum('км','mi','мч') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Единицы одометра',
  `current_mileage` int(11) DEFAULT NULL COMMENT 'Текущий пробег',
  `date_buy` date DEFAULT NULL COMMENT 'Дата покупки',
  `price_buy` int(11) DEFAULT NULL COMMENT 'Цена покупки',
  `price_sell` int(11) DEFAULT NULL COMMENT 'Цена продажи',
  `date_sell` date DEFAULT NULL COMMENT 'Дата продажи',
  `created_at` date DEFAULT NULL COMMENT 'Дата создания',
  `updated_at` date DEFAULT NULL COMMENT 'Дата последних изменений',
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `fuel_place_price`
--

CREATE TABLE `fuel_place_price` (
  `id` int(11) NOT NULL,
  `on_date` date NOT NULL,
  `fluel95` float DEFAULT NULL,
  `fluel92` float DEFAULT NULL,
  `fluel100` float DEFAULT NULL,
  `fluel98` float DEFAULT NULL,
  `fluel98_top` float DEFAULT NULL,
  `fluel95_top` float DEFAULT NULL,
  `fluel92_top` float DEFAULT NULL,
  `fluelDT_top` float DEFAULT NULL,
  `fluelDT` float DEFAULT NULL,
  `fuel_service_place_id` int(11) DEFAULT NULL,
  `created_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `fuel_service`
--

CREATE TABLE `fuel_service` (
  `id` int(11) NOT NULL,
  `avto_changelog_id` int(11) NOT NULL,
  `value` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `fuel_service_place_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `fuel_service_category`
--

CREATE TABLE `fuel_service_category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Категории (наименование) заправок';

-- --------------------------------------------------------

--
-- Структура таблицы `fuel_service_place`
--

CREATE TABLE `fuel_service_place` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coordinates` point NOT NULL,
  `fuel_service_category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `sto_category_service`
--

CREATE TABLE `sto_category_service` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Сети СТО';

-- --------------------------------------------------------

--
-- Структура таблицы `sto_service`
--

CREATE TABLE `sto_service` (
  `id` int(11) NOT NULL,
  `avto_changelog_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fuel_service_place_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `sto_service_items`
--

CREATE TABLE `sto_service_items` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` float NOT NULL,
  `service_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `sto_service_place`
--

CREATE TABLE `sto_service_place` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adress` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `coordinates` point NOT NULL,
  `categoty_service_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица сервисов обслуживания';

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `avto_changelog`
--
ALTER TABLE `avto_changelog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `avto_id` (`avto_id`);

--
-- Индексы таблицы `avto_mark`
--
ALTER TABLE `avto_mark`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `avto_model`
--
ALTER TABLE `avto_model`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `avto_mark_id` (`avto_mark_id`);

--
-- Индексы таблицы `car`
--
ALTER TABLE `car`
  ADD PRIMARY KEY (`id`),
  ADD KEY `avto_model` (`avto_model_id`);

--
-- Индексы таблицы `fuel_place_price`
--
ALTER TABLE `fuel_place_price`
  ADD KEY `fuel_service_place_id` (`fuel_service_place_id`);

--
-- Индексы таблицы `fuel_service`
--
ALTER TABLE `fuel_service`
  ADD PRIMARY KEY (`id`),
  ADD KEY `avto_changelog_id` (`avto_changelog_id`),
  ADD KEY `fuel_service_place_id` (`fuel_service_place_id`);

--
-- Индексы таблицы `fuel_service_category`
--
ALTER TABLE `fuel_service_category`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `fuel_service_place`
--
ALTER TABLE `fuel_service_place`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fuel_service_category_id` (`fuel_service_category_id`);

--
-- Индексы таблицы `sto_category_service`
--
ALTER TABLE `sto_category_service`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `sto_service`
--
ALTER TABLE `sto_service`
  ADD PRIMARY KEY (`id`),
  ADD KEY `avto_changelog_id` (`avto_changelog_id`),
  ADD KEY `fuel_service_place_id` (`fuel_service_place_id`);

--
-- Индексы таблицы `sto_service_items`
--
ALTER TABLE `sto_service_items`
  ADD KEY `service_id` (`service_id`);

--
-- Индексы таблицы `sto_service_place`
--
ALTER TABLE `sto_service_place`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoty_service_id` (`categoty_service_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `avto_changelog`
--
ALTER TABLE `avto_changelog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `avto_mark`
--
ALTER TABLE `avto_mark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `avto_model`
--
ALTER TABLE `avto_model`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `car`
--
ALTER TABLE `car`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `fuel_service`
--
ALTER TABLE `fuel_service`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `fuel_service_category`
--
ALTER TABLE `fuel_service_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `fuel_service_place`
--
ALTER TABLE `fuel_service_place`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `sto_category_service`
--
ALTER TABLE `sto_category_service`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `sto_service_place`
--
ALTER TABLE `sto_service_place`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `avto_changelog`
--
ALTER TABLE `avto_changelog`
  ADD CONSTRAINT `avto_changelog_ibfk_1` FOREIGN KEY (`avto_id`) REFERENCES `car` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `avto_model`
--
ALTER TABLE `avto_model`
  ADD CONSTRAINT `avto_model_ibfk_1` FOREIGN KEY (`avto_mark_id`) REFERENCES `avto_mark` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `fuel_place_price`
--
ALTER TABLE `fuel_place_price`
  ADD CONSTRAINT `fuel_place_price_ibfk_1` FOREIGN KEY (`fuel_service_place_id`) REFERENCES `fuel_service_place` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `fuel_service`
--
ALTER TABLE `fuel_service`
  ADD CONSTRAINT `fuel_service_ibfk_1` FOREIGN KEY (`avto_changelog_id`) REFERENCES `avto_changelog` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fuel_service_ibfk_2` FOREIGN KEY (`fuel_service_place_id`) REFERENCES `fuel_service_place` (`id`);

--
-- Ограничения внешнего ключа таблицы `fuel_service_place`
--
ALTER TABLE `fuel_service_place`
  ADD CONSTRAINT `fuel_service_place_ibfk_1` FOREIGN KEY (`fuel_service_category_id`) REFERENCES `fuel_service_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `sto_service`
--
ALTER TABLE `sto_service`
  ADD CONSTRAINT `sto_service_ibfk_1` FOREIGN KEY (`avto_changelog_id`) REFERENCES `avto_changelog` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sto_service_ibfk_2` FOREIGN KEY (`fuel_service_place_id`) REFERENCES `fuel_service_place` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `sto_service_items`
--
ALTER TABLE `sto_service_items`
  ADD CONSTRAINT `sto_service_items_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `sto_service` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `sto_service_place`
--
ALTER TABLE `sto_service_place`
  ADD CONSTRAINT `sto_service_place_ibfk_1` FOREIGN KEY (`categoty_service_id`) REFERENCES `sto_category_service` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
