#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"
#include "HardwareSerial.h"
//------------------
#define sizeOfQueue 10
#define North 1
#define South 2
#define East 3
#define West 4

QueueHandle_t Queue1;
QueueHandle_t Queue2;
QueueHandle_t Queue3;
QueueHandle_t Queue4;

SemaphoreHandle_t Mutex1;
SemaphoreHandle_t Mutex2;
SemaphoreHandle_t Mutex3;
SemaphoreHandle_t Mutex4;

int carEast;
int carWest;
int carNorth;
int carSouth;

int direction1;
int direction2;
int direction3;
int direction4;
//int car1, car2, car3, car4;
int entryID;
int direction;

int carIDcreate()
{
  int carID = random(100);
  return carID;
}

/*int CarDestinationCreate()
{
  int destinationID;
  direction = (rand() % 4) +1;

  switch (direction)
  {
    case 1:
      destinationID = North;
      Serial.println("the destination is North");
      return destinationID;
      break;

    case 2:
      destinationID = South;
      Serial.println("the destination is South");
      return destinationID;
      break;

    case 3:
      destinationID = East;
      Serial.println("the destination is East");
      return destinationID;
      break;

    case 4:
      destinationID = West;
      Serial.println("the destination is West");
      return destinationID;
      break;
  }
}*/

int CarDestinationCreate(int entry)
{
  int destinationID;
  do
  {
    destinationID = (rand() % 4) + 1;
  } while (destinationID == entry);

  switch (destinationID)
  {
    case 1:
      Serial.println("the destination is North");
      break;
    case 2:
      Serial.println("the destination is South");
      break;
    case 3:
      Serial.println("the destination is East");
      break;
    case 4:
      Serial.println("the destination is West");
      break;
  }

  return destinationID;
}


void EastComingCarTask(void *p)
{
  entryID = 3;
  while (1)
  {
    /*Serial.println("Car is coming from the East entry");
    carEast = carIDcreate();
    Serial.println(carEast);
    do
    {
      direction3 = CarDestinationCreate();
    } while (entryID == direction3);*/

    Serial.println("Car is coming from the East entry");
    carEast = carIDcreate();
    Serial.println(carEast);
    direction3 = CarDestinationCreate(entryID);

    if (direction3 == 1)
    {
      xSemaphoreTake(Mutex1, portMAX_DELAY);
      xQueueSend(Queue1, &carEast, portMAX_DELAY);
      xSemaphoreGive(Mutex1);
    }

    if (direction3 == 2)
    {
      xSemaphoreTake(Mutex3, portMAX_DELAY);
      xQueueSend(Queue3, &carEast, portMAX_DELAY);
      xSemaphoreGive(Mutex3);
    }

    if (direction3 == 4)
    {
      xSemaphoreTake(Mutex3, portMAX_DELAY);
      xQueueSend(Queue3, &carEast, portMAX_DELAY);
      xSemaphoreGive(Mutex3);

      xSemaphoreTake(Mutex4, portMAX_DELAY);
      xQueueSend(Queue4, &carEast, portMAX_DELAY);
      xSemaphoreGive(Mutex4);
    }

    vTaskDelay(pdMS_TO_TICKS(5000));
  }
}

void WestComingCarTask(void *p)
{
  entryID = 4;
  while (1)
  {
    Serial.println("Car is coming from the West entry");
    carWest = carIDcreate();
    Serial.println(carWest);
    direction4 = CarDestinationCreate(entryID);
    

    if (direction4 == 1)
    {
      xSemaphoreTake(Mutex2, portMAX_DELAY);
      xQueueSend(Queue2, &carWest, portMAX_DELAY);
      xSemaphoreGive(Mutex2);
    }

    if (direction4 == 2)
    {
      xSemaphoreTake(Mutex4, portMAX_DELAY);
      xQueueSend(Queue4, &carWest, portMAX_DELAY);
      xSemaphoreGive(Mutex4);
    }

    if (direction4 == 3)
    {
      xSemaphoreTake(Mutex1, portMAX_DELAY);
      xQueueSend(Queue1, &carWest, portMAX_DELAY);
      xSemaphoreGive(Mutex1);

      xSemaphoreTake(Mutex2, portMAX_DELAY);
      xQueueSend(Queue2, &carWest, portMAX_DELAY);
      xSemaphoreGive(Mutex2);
    }

    vTaskDelay(pdMS_TO_TICKS(5000));
  }
}

void SouthComingCarTask(void *p)
{
  entryID = 2;
  while (1)
  {
    Serial.println("Car is coming from the South entry");
    carSouth = carIDcreate();
    Serial.println(carSouth);
    direction2 = CarDestinationCreate(entryID);
    
    if (direction2 == 1)
    {
      xSemaphoreTake(Mutex2, portMAX_DELAY);
      xQueueSend(Queue2, &carSouth, portMAX_DELAY);
      xSemaphoreGive(Mutex2);

      xSemaphoreTake(Mutex4, portMAX_DELAY);
      xQueueSend(Queue4, &carSouth, portMAX_DELAY);
      xSemaphoreGive(Mutex4);
    }

    if (direction2 == 3)
    {
      xSemaphoreTake(Mutex3, portMAX_DELAY);
      xQueueSend(Queue3, &carSouth, portMAX_DELAY);
      xSemaphoreGive(Mutex3);
    }

    if (direction2 == 4)
    {
      xSemaphoreTake(Mutex4, portMAX_DELAY);
      xQueueSend(Queue4, &carSouth, portMAX_DELAY);
      xSemaphoreGive(Mutex4);
    }

    vTaskDelay(pdMS_TO_TICKS(5000));
  }
}

void NorthComingCarTask(void *p)
{
  entryID = 1;
  while (1)
  {
    Serial.println("Car is coming from the North entry");
    carNorth = carIDcreate();
    Serial.println(carNorth);
    direction1 = CarDestinationCreate(entryID);

    if (direction1 == 2)
    {
      xSemaphoreTake(Mutex1, portMAX_DELAY);
      xQueueSend(Queue1, &carNorth, portMAX_DELAY);
      xSemaphoreGive(Mutex1);

      xSemaphoreTake(Mutex3, portMAX_DELAY);
      xQueueSend(Queue3, &carNorth, portMAX_DELAY);
      xSemaphoreGive(Mutex3);
    }

    if (direction1 == 3)
    {
      xSemaphoreTake(Mutex1, portMAX_DELAY);
      xQueueSend(Queue1, &carNorth, portMAX_DELAY);
      xSemaphoreGive(Mutex1);
    }

    if (direction1 == 4)
    {
      xSemaphoreTake(Mutex2, portMAX_DELAY);
      xQueueSend(Queue2, &carNorth, portMAX_DELAY);
      xSemaphoreGive(Mutex2);
    }

    vTaskDelay(pdMS_TO_TICKS(5000));
  }
}

void intersectionCoordination(void *p)
{
  while (1)
  {
  /*  xSemaphoreTake(Mutex1, portMAX_DELAY);
    xQueueReceive(Queue1, &carNorth, portMAX_DELAY);
    xSemaphoreGive(Mutex1);

    xSemaphoreTake(Mutex2, portMAX_DELAY);
    xQueueReceive(Queue2, &carSouth, portMAX_DELAY);
    xSemaphoreGive(Mutex2);

    xSemaphoreTake(Mutex3, portMAX_DELAY);
    xQueueReceive(Queue3, &carEast, portMAX_DELAY);
    xSemaphoreGive(Mutex3);

    xSemaphoreTake(Mutex4, portMAX_DELAY);
    xQueueReceive(Queue4, &carWest, portMAX_DELAY);
    xSemaphoreGive(Mutex4);

    Serial.print("Queue1 (North): ");
    Serial.println(carNorth);
    Serial.print(" | Queue2 (South): ");
    Serial.println(carSouth);
    Serial.print(" | Queue3 (East): ");
    Serial.println(carEast);
    Serial.print(" | Queue4 (West): ");
    Serial.println(carWest);

  */

    int AllowedCarToPass = random(1, 5);  // Generate a random number between 1 and 4

    // Choose the queue to read from based on the random number
    int car;
    switch (AllowedCarToPass)
    {
      case 1:
        xSemaphoreTake(Mutex1, portMAX_DELAY);
        xQueueReceive(Queue1, &car, portMAX_DELAY);
        xSemaphoreGive(Mutex1);
        Serial.print("Reading from Queue1 (North): ");
        break;

      case 2:
        xSemaphoreTake(Mutex2, portMAX_DELAY);
        xQueueReceive(Queue2, &car, portMAX_DELAY);
        xSemaphoreGive(Mutex2);
        Serial.print("Reading from Queue2 (South): ");
        break;

      case 3:
        xSemaphoreTake(Mutex3, portMAX_DELAY);
        xQueueReceive(Queue3, &car, portMAX_DELAY);
        xSemaphoreGive(Mutex3);
        Serial.print("Reading from Queue3 (East): ");
        break;

      case 4:
        xSemaphoreTake(Mutex4, portMAX_DELAY);
        xQueueReceive(Queue4, &car, portMAX_DELAY);
        xSemaphoreGive(Mutex4);
        Serial.print("Reading from Queue4 (West): ");
        break;
    }

    Serial.println(car);

    vTaskDelay(pdMS_TO_TICKS(5000));
  }

}

void setup()
{
  Serial.begin(9600);

  Queue1 = xQueueCreate(sizeOfQueue, sizeof(int));
  Queue2 = xQueueCreate(sizeOfQueue, sizeof(int));
  Queue3 = xQueueCreate(sizeOfQueue, sizeof(int));
  Queue4 = xQueueCreate(sizeOfQueue, sizeof(int));

  Mutex1 = xSemaphoreCreateMutex();
  Mutex2 = xSemaphoreCreateMutex();
  Mutex3 = xSemaphoreCreateMutex();
  Mutex4 = xSemaphoreCreateMutex();

  xTaskCreate(intersectionCoordination, "Intersection Coordination", 2048, NULL, 1, NULL);

  xTaskCreate(EastComingCarTask, "East Intersection Entry", 1024, NULL, 1, NULL);
  xTaskCreate(WestComingCarTask, "West Intersection Entry", 1024, NULL, 1, NULL);
  xTaskCreate(SouthComingCarTask, "South Intersection Entry", 1024, NULL, 1, NULL);
  xTaskCreate(NorthComingCarTask, "North Intersection Entry", 1024, NULL, 1, NULL);
}

void loop()
{
}
