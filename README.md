# ♈ ARIES MOD HUB

![Version](https://img.shields.io/badge/version-2.0.5-emerald)
![Platform](https://img.shields.io/badge/platform-windows-lightgrey)
![License](https://img.shields.io/badge/license-MIT-10b981)

**Aries Mod Hub Terminal** to oficjalne narzędzie automatyzujące dla społeczności [Aries Hub](https://amongus.igornowakowski.pl). Skrypt w formacie `.bat` pozwala na błyskawiczną konfigurację Among Us, instalację silników modów (BepInEx) oraz zarządzanie assetami w mrocznym, terminalowym stylu.

---

## 🚀 Główne Protokoły

* **LOCAL NODE:** Instalacja serwerów (`regionInfo.json`) oraz AUnlocker (kosmetyki).
* **MOD PROTOCOLS:** Pełna obsługa *Town Of Us Mira* oraz *Level Impostor*.
* **ASSET MANAGER:** Interaktywna lista plików DLL z możliwością ich bezpiecznego usuwania.
* **VANILLA RESTORE:** Przywracanie czystej wersji gry (usuwanie BepInEx, dotnet, mono i plików tymczasowych).
* **AUTO-UPDATE:** Skrypt sam sprawdza wersję przy starcie i pozwala na aktualizację "w locie".

---

## 💻 Instalacja

1.  Pobierz najnowszą wersję `AriesModHub.bat`.
2.  Przenieś plik w dowolne miejsce (nie musi być w folderze gry).
3.  Uruchom i wklej ścieżkę do swojego Among Us, gdy skrypt o to poprosi.

> **Wymagania:** System Windows oraz połączenie z internetem (do pobierania plików DLL i BepInEx).

---

## 🛠️ Architektura i Bezpieczeństwo

Skrypt wykorzystuje natywne narzędzia systemu Windows:
* **cURL:** Do bezpiecznego pobierania plików z serwerów Aries.
* **Tar:** Do rozpakowywania paczek silnika bez potrzeby instalowania WinRARa/7-Zipa.
* **Chcp 65001:** Pełne wsparcie dla kodowania UTF-8 (ikony i symbole ASCII).

---

## 📄 Licencja

Projekt jest udostępniany na licencji **MIT**. Oznacza to, że kod jest otwarty, a Ty możesz go modyfikować i udostępniać dalej, pod warunkiem zachowania informacji o autorstwie.

*Copyright (c) 2026 Aries Mod Hub // Igor Nowakowski*

---

<div align="center">
  <p><b>ARIES // HUB</b></p>
  <p>Built for the community. Not affiliated with Innersloth LLC.</p>
</div>
