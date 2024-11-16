void kernel_main() {
    // Đảm bảo rằng chỉ khai báo một lần
    char *video_memory = (char*) 0xb8000;  // Địa chỉ của video memory
    video_memory[0] = 'K';  // Hiển thị chữ 'K' tại vị trí đầu tiên
    video_memory[1] = 0x07; // Màu chữ (đen trên trắng)
}

void _start() {
    kernel_main();    // Gọi kernel
    while (1);        // Dừng chương trình tại đây
}

