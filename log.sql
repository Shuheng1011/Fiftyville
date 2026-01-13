-- Keep a log of any SQL queries you execute as you solve the mystery.
-- GIVEN INFORMATION: TIME: JULY 28, PLACE: HUMPHREY STREET

SELECT description FROM crime_scene_reports WHERE day = 28 AND month = 7;

-- Vandalism: 12:04, no witness
-- Shoplifting: 3:01, two witnesses
-- Duck theft 10:15 am, 3 witnesses, at bakery
-- Money laundering 20:30 no witness
-- Littering: 16:36 no witness

SELECT transcript FROM interviews WHERE month = 7 AND day = 28;
-- ATM on Legget Street, Thief withdrew money
-- Planning to take earliest flight out of fiftyville, asked person on other end to buy ticket

SELECT license_plate FROM bakery_security_logs WHERE month = 7
AND day = 28
AND hour = 10
AND minute <= 25
AND minute >= 5;

SELECT name FROM people WHERE license_plate IN(
    SELECT license_plate FROM bakery_security_logs
    WHERE month = 7
    AND day = 28
    AND hour = 10
    AND minute <= 25
    AND minute >= 5
);

SELECT DISTINCT name
FROM people
JOIN phone_calls ON people.phone_number = phone_calls.caller
WHERE people.license_plate IN(
    SELECT license_plate FROM bakery_security_logs
    WHERE month = 7
    AND day = 28
    AND hour = 10
    AND minute <= 25
    AND minute >= 5
    AND year = 2024
)
AND phone_calls.month = 7
AND phone_calls.day = 28
AND phone_calls.year = 2024
AND phone_calls.duration < 60
;

-- only 4 people that day made a phone call that day and was at the bakery

SELECT name FROM people
JOIN bank_accounts ON bank_accounts.person_id = people.id
JOIN atm_transactions ON atm_transactions.account_number = bank_accounts.account_number
WHERE atm_location = 'Leggett Street'
AND transaction_type = 'withdraw'
AND month = 7
AND day = 28
AND year = 2024;
-- Suspect is now limited to either Bruce or Diana

SELECT full_name, id FROM airports WHERE city = 'Fiftyville';

SELECT destination_airport_id FROM flights WHERE year = 2024
AND month = 7
AND day = 29
AND origin_airport_id = 8
ORDER BY flights.hour ASC;

SELECT city FROM airports WHERE id = 4;
-- Suspect is escaping to NYC

SELECT id FROM flights WHERE origin_airport_id = 8
AND destination_airport_id = 4
AND year = 2024
AND month = 7
AND day = 29;

SELECT name FROM people
JOIN passengers ON people.passport_number = passengers.passport_number
WHERE passengers.flight_id = 36;
-- Suspect is Bruce

SELECT phone_number FROM people WHERE name = 'Bruce';

SELECT receiver FROM phone_calls WHERE caller = '(367) 555-5533'
AND month = 7
AND day = 28
AND year = 2024
AND duration < 60;

-- reciever name isolated

SELECT name FROM people WHERE phone_number = '(375) 555-8161';

-- Acquaintance is Robin
