
# Opportunity Summary Custom Component

## Opis projektu  
**OpportunitySummary** to customowy komponent dla **Salesforce Lightning**, który umożliwia wyświetlanie i zarządzanie danymi dotyczącymi szans sprzedaży (*Opportunities*).  
Komponent ten pobiera, edytuje oraz zatwierdza informacje o szansach sprzedaży, w tym powiązane:  
- produkty,  
- członków zespołu,  
- usługi marketingowe,  
- zasoby na sprzedaż.  

---

## Zawartość projektu  
Projekt składa się z kilku plików, które współpracują ze sobą, aby zapewnić pełną funkcjonalność:  

- **`OpportunitySummary.cmp`** – główny plik komponentu Lightning  
- **`OpportunitySummaryController.js`** – kontroler frontendu obsługujący interakcje użytkownika  
- **`OpportunitySummaryHelper.js`** – plik pomocniczy zawierający funkcje pomocnicze i obsługę błędów  
- **`OpportunitySummaryController.cls`** – kontroler backendowy w Apex obsługujący zapytania do bazy danych Salesforce  
- **`OpportunitySummaryService.cls`** – serwis do obsługi logiki biznesowej  
- **`OpportunitySummaryControllerTest.cls`** oraz **`OpportunitySummaryServiceTest.cls`** – testy jednostkowe dla kodu w Apex  

---

## Funkcjonalności  

### Pobieranie danych szansy sprzedaży  
- Ładowanie danych dotyczących szansy sprzedaży na podstawie jej **ID**  
- Pobieranie i ustawianie dostępnych opcji dla pól wyboru  

### Edycja i zarządzanie danymi  
- Możliwość **usuwania i przywracania**:  
  - produktów,  
  - członków zespołu,  
  - usług marketingowych  
- **Zatwierdzanie i aktualizacja** szans sprzedaży  

### Obsługa powiadomień i błędów  
- Wyświetlanie komunikatów o błędach i sukcesach za pomocą **toasts**  
- Obsługa **walidacji formularzy**  

### Integracja z Salesforce Navigation API  
- Przekierowanie użytkownika do szczegółowych **widoków rekordów**  

### Przykładowy wygląd komponentu
![screencapture-dreamteamitp-bemaindev-sandbox-lightning-force-lightning-r-Opportunity-006RR000007531HYAQ-view-2025-03-13-16_25_56](https://github.com/user-attachments/assets/f5f3180e-1c11-4956-b863-84b825d10c36)
