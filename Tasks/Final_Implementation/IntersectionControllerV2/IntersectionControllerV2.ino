#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"

//------------------
#define sizeOfQueue 10
#define North 0
#define South 1
#define East 2
#define West 3

QueueHandle_t Queue1;
QueueHandle_t Queue2;
QueueHandle_t Queue3;
QueueHandle_t Queue4;

SemaphoreHandle_t Mutex1;
SemaphoreHandle_t Mutex2;
SemaphoreHandle_t Mutex3;
SemaphoreHandle_t Mutex4;

int carEast, carWest, carNorth, carSouth;
int direction0, direction1, direction2, direction3;
int car1, car2, car3, car4;
int entryID=5;

int carIDcreate()
{
  int carID = random(100);
  return carID;
}

int CarDestinationCreate(int entry)
{
  int destinationID;
  do
  {
    destinationID = rand() % 4;
  } while (destinationID == entry);

  switch (destinationID)
  {
    case 0:
      destinationID = North;
      Serial.println("the destination is North");
      return destinationID;
      break;

    case 1:
      destinationID = South;
      Serial.println("the destination is South");
      return destinationID;
      break;

    case 2:
      destinationID = East;
      Serial.println("the destination is East");
      return destinationID;
      break;

    case 3:
      destinationID = West;
      Serial.println("the destination is West");
      return destinationID;
      break;
  }
}

void EastComingCarTask(void *p)
{
   entryID = 2;
  while (1)
  {
    Serial.println("Car is coming from the East entry");
    carEast = carIDcreate();
    do
    {
      direction2 = CarDestinationCreate(entryID);
    } while (entryID == direction2);

    if (direction2 == 0)
    {
      xSemaphoreTake(Mutex1, portMAX_DELAY);
      xQueueSend(Queue1, &carEast, portMAX_DELAY);
      xSemaphoreGive(Mutex1);
    }

    if (direction2 == 1)
    {
      xSemaphoreTake(Mutex3, portMAX_DELAY);
      xQueueSend(Queue3, &carEast, portMAX_DELAY);
      xSemaphoreGive(Mutex3);
    }

    if (direction2 == 3)
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
  int entryID = 3;
  while (1)
  {
    Serial.println("Car is coming from the West entry");
    carWest = carIDcreate();
    do
    {
      direction3 = CarDestinationCreate(entryID);
    } while (entryID == direction3);

    if (direction3 == 0)
    {
      xSemaphoreTake(Mutex2, portMAX_DELAY);
      xQueueSend(Queue2, &carWest, portMAX_DELAY);
      xSemaphoreGive(Mutex2);
    }

    if (direction3 == 1)
    {
      xSemaphoreTake(Mutex4, portMAX_DELAY);
      xQueueSend(Queue4, &carWest, portMAX_DELAY);
      xSemaphoreGive(Mutex4);
    }

    if (direction3 == 2)
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
  int entryID = 1;
  while (1)
  {
    Serial.println("Car is coming from the South entry");
    carSouth = carIDcreate();
    do
    {
      direction1 = CarDestinationCreate(entryID);
    } while (entryID == direction1);

    if (direction1 == 0)
    {
      xSemaphoreTake(Mutex2, portMAX_DELAY);
      xQueueSend(Queue2, &carSouth, portMAX_DELAY);
      xSemaphoreGive(Mutex2);

      xSemaphoreTake(Mutex4, portMAX_DELAY);
      xQueueSend(Queue4, &carSouth, portMAX_DELAY);
      xSemaphoreGive(Mutex4);
    }

    if (direction1 == 2)
    {
      xSemaphoreTake(Mutex3, portMAX_DELAY);
      xQueueSend(Queue3, &carSouth, portMAX_DELAY);
      xSemaphoreGive(Mutex3);
    }

    if (direction1 == 3)
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
  int entryID = 0;
  while (1)
  {
    Serial.println("Car is coming from the North entry");
    carNorth = carIDcreate();
    do
    {
      direction0 = CarDestinationCreate(entryID);
    } while (entryID == direction0);

    if (direction0 == 1)
    {
      xSemaphoreTake(Mutex1, portMAX_DELAY);
      xQueueSend(Queue1, &carNorth, portMAX_DELAY);
      xSemaphoreGive(Mutex1);

      xSemaphoreTake(Mutex3, portMAX_DELAY);
      xQueueSend(Queue3, &carNorth, portMAX_DELAY);
      xSemaphoreGive(Mutex3);
    }

    if (direction0 == 2)
    {
      xSemaphoreTake(Mutex1, portMAX_DELAY);
      xQueueSend(Queue1, &carNorth, portMAX_DELAY);
      xSemaphoreGive(Mutex1);
    }

    if (direction0 == 3)
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
    xSemaphoreTake(Mutex1, portMAX_DELAY);
    xQueueReceive(Queue1, &car1, portMAX_DELAY);
    xSemaphoreGive(Mutex1);

    xSemaphoreTake(Mutex2, portMAX_DELAY);
    xQueueReceive(Queue2, &car2, portMAX_DELAY);
    xSemaphoreGive(Mutex2);

    xSemaphoreTake(Mutex3, portMAX_DELAY);
    xQueueReceive(Queue3, &car3, portMAX_DELAY);
    xSemaphoreGive(Mutex3);

    xSemaphoreTake(Mutex4, portMAX_DELAY);
    xQueueReceive(Queue4, &car4, portMAX_DELAY);
    xSemaphoreGive(Mutex4);

    Serial.print("Queue1: ");
    Serial.println(car1);
    Serial.print(" | Queue2: ");
    Serial.println(car2);
    Serial.print(" | Queue3: ");
    Serial.println(car3);
    Serial.print(" | Queue4: ");
    Serial.println(car4);

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