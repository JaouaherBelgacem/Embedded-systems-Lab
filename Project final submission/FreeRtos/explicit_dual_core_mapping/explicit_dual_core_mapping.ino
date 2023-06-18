#include <Arduino.h>
#include <freertos/FreeRTOS.h>
#include <freertos/task.h>
#include <freertos/queue.h>
#include <freertos/semphr.h>

// Define the turn direction options
enum TurnDirection {
  LEFT,
  STRAIGHT,
  RIGHT
};

// Define the road names
const char* roadNames[] = {"North", "East", "South", "West"};
SemaphoreHandle_t deadlockSemaphore;
SemaphoreHandle_t carPassedMutex;

// Structure to represent a car
struct Car {
  int id;
  int roadIndex;
  TurnDirection turnDirection;
};

// Queue for each road
QueueHandle_t northQueue;
QueueHandle_t eastQueue;
QueueHandle_t southQueue;
QueueHandle_t westQueue;

// Flag to track if a car has been allowed to pass
bool carPassed = false;

// Intersection controller task
void intersectionControllerTask(void* parameter) {
  int count = 0;

  while (true) {
    // Check the queues and allow cars to pass based on booking order
    Car car;

    if (xQueueReceive(northQueue, &car, 0) == pdTRUE) {
      // Check for a matching scenario with a car approaching from the South road
      Car oppositeCar;
      if (xQueueReceive(southQueue, &oppositeCar, 0) == pdTRUE && car.turnDirection == oppositeCar.turnDirection) {
        // Both cars want to go straight or turn right, allow them to pass simultaneously
        Serial.printf("                                1. Car ID: %d and %d are both allowed to pass simultaneously (Both going Straight / turning right).\n", car.id, oppositeCar.id);
        Serial.println("----------------------------------------------------------------------------------------------------------------------------------------------------------");
        vTaskDelay(1000); // Simulate the cars passing through the intersection
        count++;

        // Protect the critical section with the mutex
        xSemaphoreTake(carPassedMutex, portMAX_DELAY);
        carPassed = true;
        xSemaphoreGive(carPassedMutex);
      } else {
        // Only the car from the North road can pass

        Serial.printf("\n                                   Normal Sequence : North_Car is allowed to cross the junction -> East_Car,-> Southast_Car,-> West_Car in sequence.\n",  roadNames[car.roadIndex]);
        Serial.println("----------------------------------------------------------------------------------------------------------------------------------------------------------");

        count++;

        // Protect the critical section with the mutex
        xSemaphoreTake(carPassedMutex, portMAX_DELAY);
        carPassed = true;
        xSemaphoreGive(carPassedMutex);
      }
    }

    // Check the remaining conditions only if a car has not been allowed to pass
    if (!carPassed) {
      if (xQueueReceive(eastQueue, &car, 0) == pdTRUE) {
        // Check for a matching scenario with a car approaching from the West road
        Car oppositeCar;
        if (xQueueReceive(westQueue, &oppositeCar, 0) == pdTRUE && car.turnDirection == oppositeCar.turnDirection) {
          // Both cars want to go straight or turn right, allow them to pass simultaneously
          Serial.printf("                                   Car ID: %d and %d are both allowed to pass simultaneously (Both going Straight / turning right).\n", car.id, oppositeCar.id);
          Serial.println("----------------------------------------------------------------------------------------------------------------------------------------------------------");
          vTaskDelay(1000); // Simulate the cars passing through the intersection
          count++;

          // Protect the critical section with the mutex
          xSemaphoreTake(carPassedMutex, portMAX_DELAY);
          carPassed = true;
          xSemaphoreGive(carPassedMutex);
        } else {
          // Only the car from the East road can pass

          Serial.printf("\n                                   Normal Sequence : North_Car is allowed to cross the junction -> East_Car,-> Southast_Car,-> West_Car in sequence.\n",  roadNames[car.roadIndex]);
          Serial.println("----------------------------------------------------------------------------------------------------------------------------------------------------------");

          count++;

          // Protect the critical section with the mutex
          xSemaphoreTake(carPassedMutex, portMAX_DELAY);
          carPassed = true;
          xSemaphoreGive(carPassedMutex);
        }
      } else if (xQueueReceive(southQueue, &car, 0) == pdTRUE) {
        // Only the car from the South road can pass

        Serial.printf("\n                                   Normal Sequence : North_Car is allowed to cross the junction -> East_Car,-> Southast_Car,-> West_Car in sequence.\n",  roadNames[car.roadIndex]);
        Serial.println("----------------------------------------------------------------------------------------------------------------------------------------------------------");

        count++;

        // Protect the critical section with the mutex
        xSemaphoreTake(carPassedMutex, portMAX_DELAY);
        carPassed = true;
        xSemaphoreGive(carPassedMutex);
      } else if (xQueueReceive(westQueue, &car, 0) == pdTRUE) {
        // Check for a matching scenario with a car approaching from the East road
        Car oppositeCar;
        if (xQueueReceive(eastQueue, &oppositeCar, 0) == pdTRUE && car.turnDirection == oppositeCar.turnDirection) {
          // Both cars want to go straight or turn right, allow them to pass simultaneously
          Serial.printf("                                   Car ID: %d and %d are both allowed to pass simultaneously (Both going Straight / turning right).\n", car.id, oppositeCar.id);
          Serial.println("----------------------------------------------------------------------------------------------------------------------------------------------------------");
          vTaskDelay(1000); // Simulate the cars passing through the intersection
          count++;

          // Protect the critical section with the mutex
          xSemaphoreTake(carPassedMutex, portMAX_DELAY);
          carPassed = true;
          xSemaphoreGive(carPassedMutex);
        } else {
          // Only the car from the West road can pass

          Serial.printf("\n                                   Normal Sequence : North_Car is allowed to cross the junction -> East_Car,-> Southast_Car,-> West_Car in sequence.\n",  roadNames[car.roadIndex]);
          Serial.println("----------------------------------------------------------------------------------------------------------------------------------------------------------");

          count++;

          // Protect the critical section with the mutex
          xSemaphoreTake(carPassedMutex, portMAX_DELAY);
          carPassed = true;
          xSemaphoreGive(carPassedMutex);
        }
      }
    }

    // Reset the flag
    carPassed = false;

    // Delay before the next iteration
    vTaskDelay(100);
  }
}




void fillCarIdDirToQueues(void* parameter) {
  while (true) {
    
    // This code will run on Core 1
    // Simulate cars approaching and booking their entry into the queues

  // Cars approaching from the North road
  if (uxQueueSpacesAvailable(northQueue) > 0) {
    Car northCar;
    northCar.id = random(1000);
    northCar.roadIndex = 0; // North road index
    northCar.turnDirection = static_cast<TurnDirection>(random(1, 4));
    xQueueSend(northQueue, &northCar, portMAX_DELAY);
    Serial.printf("Car ID: %d, Approaching from:--> %s road, Wants to turn:---> ", northCar.id, roadNames[northCar.roadIndex]);
    switch (northCar.turnDirection) {
      case LEFT:
        Serial.print("Left");
        break;
      case STRAIGHT:
        Serial.print("Straight");
        break;
      case RIGHT:
        Serial.print("Right");
        break;
    }
    Serial.println();
  }

  // Cars approaching from the East road
  if (uxQueueSpacesAvailable(eastQueue) > 0) {
    Car eastCar;
    eastCar.id = random(1000);
    eastCar.roadIndex = 1; // East road index
    eastCar.turnDirection = static_cast<TurnDirection>(random(0, 3));
    xQueueSend(eastQueue, &eastCar, portMAX_DELAY);
    Serial.printf("Car ID: %d, Approaching from:--> %s road, Wants to turn:---> ", eastCar.id, roadNames[eastCar.roadIndex]);
    switch (eastCar.turnDirection) {
      case LEFT:
        Serial.print("Left");
        break;
      case STRAIGHT:
        Serial.print("Straight");
        break;
      case RIGHT:
        Serial.print("Right");
        break;
    }
    Serial.println();
  }

  // Cars approaching from the South road
  if (uxQueueSpacesAvailable(southQueue) > 0) {
    Car southCar;
    southCar.id = random(1000);
    southCar.roadIndex = 2; // South road index
    southCar.turnDirection = static_cast<TurnDirection>(random(0, 3));
    xQueueSend(southQueue, &southCar, portMAX_DELAY);
    Serial.printf("Car ID: %d, Approaching from:--> %s road, Wants to turn:---> ", southCar.id, roadNames[southCar.roadIndex]);
    switch (southCar.turnDirection) {
      case LEFT:
        Serial.print("Left");
        break;
      case STRAIGHT:
        Serial.print("Straight");
        break;
      case RIGHT:
        Serial.print("Right");
        break;
    }
    Serial.println();
  }

  // Cars approaching from the West road
  if (uxQueueSpacesAvailable(westQueue) > 0) {
    Car westCar;
    westCar.id = random(1000);
    westCar.roadIndex = 3; // West road index
    westCar.turnDirection = static_cast<TurnDirection>(random(0, 3));
    xQueueSend(westQueue, &westCar, portMAX_DELAY);
    Serial.printf("Car ID: %d, Approaching from:--> %s road, Wants to turn:---> ", westCar.id, roadNames[westCar.roadIndex]);
    switch (westCar.turnDirection) {
      case LEFT:
        Serial.print("Left");
        break;
      case STRAIGHT:
        Serial.print("Straight");
        break;
      case RIGHT:
        Serial.print("Right");
        break;
    }
    Serial.println();
  }

  // Delay before the next iteration
  delay(3000);

    // Delay before the next iteration
    vTaskDelay(100);
  }
}






void deadlockDetectionTask(void* parameter) {
  while (true) {
    // Check the status of the synchronization primitives and detect deadlocks or issues
    // This task will run on Core 0

    // Example deadlock detection scenario: Checking if a semaphore is released
    if (uxSemaphoreGetCount(deadlockSemaphore) != 0) {
      Serial.println("Warning: Semaphore deadlock detected!");
    }

    // Example issue detection scenario: Checking if a mutex is locked by a task for too long
    // ...

    // Delay before the next iteration
    vTaskDelay(5000);
  }
}

void setup() {
  Serial.begin(115200);

carPassedMutex = xSemaphoreCreateMutex();
deadlockSemaphore = xSemaphoreCreateBinary();

  // Create the queues for each road
  northQueue = xQueueCreate(10, sizeof(Car));
  eastQueue = xQueueCreate(10, sizeof(Car));
  southQueue = xQueueCreate(10, sizeof(Car));
  westQueue = xQueueCreate(10, sizeof(Car));

  // Create the intersection controller task
  xTaskCreatePinnedToCore(intersectionControllerTask, "IntersectionControllerTask", 4096, NULL, 1, NULL,tskNO_AFFINITY);
  xTaskCreatePinnedToCore(fillCarIdDirToQueues, "fillQueues", 4096, NULL, 1, NULL,tskNO_AFFINITY);
// Create the deadlock detection task and schedule it to run on Core 0
  xTaskCreatePinnedToCore(deadlockDetectionTask, "DeadlockDetectionTask", 4096, NULL, 1, NULL,tskNO_AFFINITY);

}

void loop() {
 
}