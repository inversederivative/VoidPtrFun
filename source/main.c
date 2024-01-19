#include <VoidPtrFun.h>

void PointerFun(void* vptr)
{

	Person* person = (Person*)vptr;

	printf("Name: %s, ID: %d\n", person->Name, person->ID);
}

int main(int argc, char** argv)
{
	Person* ps = (Person*)malloc(sizeof(Person));

	ps->ID = 01;
    ps->Name = "Albert Einstein";
	PointerFun(ps);


    // Do it fake now

    // Struct has two members, int (4 bytes + buffer) and char* (8 bits)
    void* fakePerson = malloc(16);

    int fakeID = 02;
    char* fakeName = "Walter White";

    *(int*)fakePerson = fakeID; // Set the first 8 bits with the fakeID

    // Set the second 8 bits with the fakeName
    // Note it would be better to do size of, but because we know, we know.
    *((char**)(fakePerson + 8)) = fakeName;

    PointerFun(fakePerson);

    // %zu is used for a portable size_t, i.e. the return value of sizeof()
    printf("Size of int: %zu Bytes\nSize of char*: %zu Bytes\n", sizeof(int), sizeof(char*));
    printf("Size of Person: %zu Bytes\n", sizeof(Person));
}

