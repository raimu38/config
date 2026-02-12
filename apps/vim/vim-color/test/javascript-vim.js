interface User {
  id: number;
  name: string;
}

const active: boolean = true;

function getUserInfo(id: number): string {
  if (id > 0) {
    const message = `User ID is ${id}`;
    return message;
  }
  return "Invalid ID";
}

const user: User = { id: 101, name: "GitHub" };
console.log(getUserInfo(user.id));
