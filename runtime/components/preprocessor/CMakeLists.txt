set(PKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# --- Audio Preprocessor Interface ---
add_litertlm_library(runtime_components_preprocessor_audio_preprocessor INTERFACE)
add_library(LiteRT::Components::Preprocessor::Audio ALIAS runtime_components_preprocessor_audio_preprocessor)

target_include_directories(runtime_components_preprocessor_audio_preprocessor 
  INTERFACE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
)

# --- Audio Preprocessor MiniAudio ---
add_litertlm_library(runtime_components_preprocessor_audio_preprocessor_miniaudio STATIC
  audio_preprocessor_miniaudio.cc
)
add_library(LiteRT::Components::Preprocessor::AudioMiniAudio ALIAS runtime_components_preprocessor_audio_preprocessor_miniaudio)

target_include_directories(runtime_components_preprocessor_audio_preprocessor_miniaudio
  PRIVATE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)

target_link_libraries(runtime_components_preprocessor_audio_preprocessor_miniaudio
  PUBLIC
    LiteRT::Components::Preprocessor::Audio
    LiteRT::Components::Preprocessor::MelFilterBank
    runtime_engine_io_types
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
    miniaudio # Specific dependency
)

# --- Bypass Audio Preprocessor ---
add_litertlm_library(runtime_components_preprocessor_by_pass_audio_preprocessor INTERFACE)
add_library(LiteRT::Components::Preprocessor::AudioBypass ALIAS runtime_components_preprocessor_by_pass_audio_preprocessor)

target_include_directories(runtime_components_preprocessor_by_pass_audio_preprocessor
  INTERFACE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
)

# --- Bypass Image Preprocessor ---
add_litertlm_library(runtime_components_preprocessor_by_pass_image_preprocessor INTERFACE)
add_library(LiteRT::Components::Preprocessor::ImageBypass ALIAS runtime_components_preprocessor_by_pass_image_preprocessor)

target_include_directories(runtime_components_preprocessor_by_pass_image_preprocessor
  INTERFACE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
)

# --- Image Preprocessor Interface ---
add_litertlm_library(runtime_components_preprocessor_image_preprocessor INTERFACE)
add_library(LiteRT::Components::Preprocessor::Image ALIAS runtime_components_preprocessor_image_preprocessor)

target_include_directories(runtime_components_preprocessor_image_preprocessor
  INTERFACE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)

# --- Mel Filterbank ---
add_litertlm_library(runtime_components_preprocessor_mel_filterbank STATIC
  mel_filterbank.cc
)
add_library(LiteRT::Components::Preprocessor::MelFilterBank ALIAS runtime_components_preprocessor_mel_filterbank)

target_include_directories(runtime_components_preprocessor_mel_filterbank
  PUBLIC
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)

target_link_libraries(runtime_components_preprocessor_mel_filterbank 
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Signal Vector Util ---
add_litertlm_library(runtime_components_preprocessor_signal_vector_util INTERFACE)
add_library(LiteRT::Components::Preprocessor::SignalVectorUtil ALIAS runtime_components_preprocessor_signal_vector_util)

target_include_directories(runtime_components_preprocessor_signal_vector_util 
  INTERFACE 
    ${GENERATED_SRC_DIR}
    ${LITERTLM_INCLUDE_PATHS}
)

# --- STB Image Preprocessor ---
add_litertlm_library(runtime_components_preprocessor_stb_image_preprocessor STATIC
  stb_image_preprocessor.cc
)
add_library(LiteRT::Components::Preprocessor::StbImage ALIAS runtime_components_preprocessor_stb_image_preprocessor)

target_include_directories(runtime_components_preprocessor_stb_image_preprocessor
  PRIVATE
    ${LITERTLM_INCLUDE_PATHS}
    ${GENERATED_SRC_DIR}
    ${CMAKE_BINARY_DIR}
)

target_link_libraries(runtime_components_preprocessor_stb_image_preprocessor
  PUBLIC
    LiteRT::Components::Preprocessor::Image
    runtime_engine_io_types
    runtime_util_convert_tensor_buffer
    runtime_util_litert_status_util
  PRIVATE
    LITERTLM_DEPS
    litert_libs
)

# --- Folder Facade ---
add_library(runtime_components_preprocessor_libs INTERFACE)
add_library(LiteRT::Components::Preprocessor ALIAS runtime_components_preprocessor_libs)

target_link_libraries(runtime_components_preprocessor_libs INTERFACE
  LiteRT::Components::Preprocessor::Audio
  LiteRT::Components::Preprocessor::AudioMiniAudio
  LiteRT::Components::Preprocessor::AudioBypass
  LiteRT::Components::Preprocessor::ImageBypass
  LiteRT::Components::Preprocessor::Image
  LiteRT::Components::Preprocessor::MelFilterBank
  LiteRT::Components::Preprocessor::SignalVectorUtil
  LiteRT::Components::Preprocessor::StbImage
)