# Technical Assessment – Flutter Application

This repository contains a Flutter application developed as part of a technical assessment. The objective was to implement a focused mobile application that loads and displays remote images while dynamically adapting the user interface based on colors extracted from the image content.

The implementation emphasizes performance, explicit state management, and deliberate technical decisions made under constrained time.

## Project Overview

The application demonstrates:

- Remote image loading with dynamic color extraction.
- UI theming derived from image color palettes.
- Smooth transitions and lightweight animations.
- Iterative refinement focused on performance and perceived responsiveness.
- Clear separation between data flow, state, and rendering responsibilities.

The project evolved through three structured development phases.

## Getting Started

1. Clone the repository.
2. Run `flutter pub get`.
3. Launch the application using `flutter run`.

## Development Timeline

**Phase 1 (Mandatory) – Initial Implementation (~2h45)**  
- Project setup and foundational UI composition.
- Image fetching and rendering.
- Color palette extraction using Material Design utilities.
- Basic animations and explicit state handling.
- Validation of the core technical approach.

**Phase 2 (Optional) – Structural and UX Refinement (~2h40)**  
- Refactoring for clearer responsibility boundaries and smaller, more focused widgets.
- Resolution of layout and image dimension edge cases.
- Improvements to responsiveness and memory usage.
- UI polish and basic accessibility adjustments.

**Phase 3 (Optional) – Performance and Perceived Responsiveness (~1h)**  
- Image prefetching to eliminate visible loading during navigation.
- Introduction of shimmer-based placeholders in place of spinners.
- Removal of duplicated `ImageProvider` instances.
- Direct image byte downloads to gain explicit control over caching and reuse.

## Key Technical Decisions

### Color Extraction

Material Design color utilities were selected over unmaintained third-party solutions. This approach avoids blocking the main thread and provides better long-term compatibility.

### State Management

State is managed using a package that I developed and actively maintain. It was chosen for this assessment because it enables explicit state transitions and side-effect handling with minimal boilerplate. This facilitated rapid iteration, predictability, and a small, maintainable codebase.

### Image Pipeline Design

The image pipeline was progressively refined to reduce redundant processing and improve the user experience:

- Prefetching ensures images are available before they are rendered.
- Byte-level image fetching allows reuse and more predictable memory behavior.
- A single source of truth prevents duplicate decoding and provider instantiation.

### UI and Animations

Animations were intentionally subtle and implemented using `flutter_animate` to enhance perceived smoothness without introducing unnecessary complexity.

## Research References

The following resources were consulted during development, particularly for color extraction and image processing decisions:

- Flutter issue discussing image color extraction and related performance considerations:  
  https://github.com/flutter/flutter/issues/122788

- Article exploring modern approaches to extracting color palettes from images in Flutter:  
  https://jwill.dev/blog/2025/06/02/Extract-Colors-From-Image.html

- Reference implementation used for image decoding and palette extraction logic (with a separate isolate added for performance improvement):  
  https://github.com/jwill/extract_palette_from_image/blob/main/lib/image.dart

## Outcome

The final version delivers a responsive and visually adaptive interface with minimal loading artifacts. The codebase reflects an iterative engineering approach, prioritizing correctness, followed by usability and performance optimization.

## Limitations and Future Improvements

Some aspects of the application would benefit from further refinement, particularly more robust error handling and broader edge-case coverage. These improvements, along with additional polish and extended testing, were intentionally deprioritized as they fall outside the time constraints defined for this assessment.

## Technologies Used

- Flutter  
- Dart  
- Material Design color utilities  
- Ctrl (Author-maintained custom state management package)  
- flutter_animate  
