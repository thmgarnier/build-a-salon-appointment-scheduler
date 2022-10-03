#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
# get list of services

  # start program
  echo -e "\nBe welcome, these are our services:"
  SERVICE_MENU() {
    # get service id
    SERVICE_ID_MENU=$($PSQL "SELECT service_id, name FROM services")
    echo "$SERVICE_ID_MENU" | while read SERVICE_ID BAR NAME
    do
      echo "$SERVICE_ID) $NAME"
    done
    read SERVICE_ID_SELECTED

    case $SERVICE_ID_SELECTED in
    1) ADVICE ;;
    2) CLASS ;;
    3) MEDICAL_CONSULTATION ;;
    *) SERVICE_MENU "Please enter a valid option." ;;
  esac
  }

  ADVICE() {
    echo -e "\nAdvice."
  }

  CLASS() {
    echo -e "\nClass."
  }
  
  MEDICAL_CONSULTATION() {
    echo -e "\nMedical consultation."
  }

  SERVICE_MENU

    # get customer info
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

    # if phone doesn't exist
    if [[ -z $CUSTOMER_NAME ]]
    then
      # get new customer name
      echo -e "\nWhat's your name?"
      read CUSTOMER_NAME
      # get new customer phone
      echo -e "\nWhat's your phone number?"
      read CUSTOMER_PHONE
      # insert new customer
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$PHONE_NUMBER')") 
    fi
    
    # set appointment
    echo -e "\nAt which time would you like your appointment?"
    read SERVICE_TIME
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone=$CUSTOMER_PHONE)")
  
    INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')") 


  