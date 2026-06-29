CREATE TABLE bookings (
    date DATE,
    time TIME,
    booking_id VARCHAR(20),
    booking_status VARCHAR(50),
    customer_id VARCHAR(20),
    vehicle_type VARCHAR(30),
    pickup_location VARCHAR(100),
    drop_location VARCHAR(100),
    v_tat INT,
    c_tat INT,
    canceled_rides_by_customer VARCHAR(100),
    canceled_rides_by_driver VARCHAR(100),
    incomplete_rides VARCHAR(10),
    incomplete_rides_reason VARCHAR(255),
    booking_value NUMERIC(10,2),
    payment_method VARCHAR(30),
    ride_distance NUMERIC(10,2),
    driver_ratings NUMERIC(3,2),
    customer_rating NUMERIC(3,2),
    vehicle_images VARCHAR(255)
);
select * from bookings;
--1. Retrieve all successful bookings.
SELECT *
FROM bookings 
WHERE booking_status = 'Success';
--2. Find the average ride distance for each vehicle type.
SELECT vehicle_type,
       AVG(ride_distance) AS average_ride_distance
FROM bookings
GROUP BY vehicle_type;
--3. Get the total number of cancelled rides by customers.
SELECT COUNT(*) AS total_customer_cancelled_rides
FROM bookings
WHERE booking_status = 'Canceled by Customer';
--4. List the top 5 customers who booked the highest number of rides.
SELECT customer_id,
       COUNT(*) AS total_bookings
FROM bookings
GROUP BY customer_id
ORDER BY total_bookings DESC
LIMIT 5;
--5. Find the number of rides cancelled by drivers.
SELECT COUNT(*) AS total_driver_cancelled_rides
FROM bookings
WHERE booking_status = 'Canceled by Driver';
--OR
SELECT canceled_rides_by_driver,
       COUNT(*) AS total_rides
FROM bookings
WHERE booking_status = 'Canceled by Driver'
GROUP BY canceled_rides_by_driver
ORDER BY total_rides DESC;
--6. Find the maximum and minimum driver ratings for Prime Sedan bookings.
SELECT MAX(driver_ratings) AS maximum_driver_rating,
       MIN(driver_ratings) AS minimum_driver_rating
FROM bookings
WHERE vehicle_type = 'Prime Sedan';
--7. Retrieve all rides where payment was made using UPI.
SELECT *
FROM bookings
WHERE payment_method = 'UPI';
--8. Find the average customer rating per vehicle type.
SELECT vehicle_type,
       AVG(customer_rating) AS average_customer_rating
FROM bookings
GROUP BY vehicle_type;
--9. Calculate the total booking value of rides completed successfully.
SELECT SUM(booking_value) AS total_booking_value
FROM bookings
WHERE booking_status = 'Success';
--10. List all incomplete rides along with the reason.
SELECT booking_id,
       incomplete_rides_reason
FROM bookings
WHERE incomplete_rides = 'Yes';