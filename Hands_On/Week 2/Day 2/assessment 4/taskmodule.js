// taskModule.js

let tasks = [];

/* =========================
   1️⃣ Callback Version
========================= */
export const addTaskCallback = (task, callback) => {
    setTimeout(() => {
        tasks.push(task);
        callback(`Task Added: ${task}`);
    }, 500);
};

export const deleteTaskCallback = (task, callback) => {
    setTimeout(() => {
        tasks = tasks.filter(t => t !== task);
        callback(`Task Deleted: ${task}`);
    }, 500);
};

export const listTasksCallback = (callback) => {
    setTimeout(() => {
        callback(`Tasks:\n${tasks.join("\n")}`);
    }, 500);
};


/* =========================
   2️⃣ Promise Version
========================= */
export const addTaskPromise = (task) =>
    new Promise(resolve => {
        setTimeout(() => {
            tasks.push(task);
            resolve(`Task Added: ${task}`);
        }, 500);
    });

export const deleteTaskPromise = (task) =>
    new Promise(resolve => {
        setTimeout(() => {
            tasks = tasks.filter(t => t !== task);
            resolve(`Task Deleted: ${task}`);
        }, 500);
    });

export const listTasksPromise = () =>
    new Promise(resolve => {
        setTimeout(() => {
            resolve(`Tasks:\n${tasks.join("\n")}`);
        }, 500);
    });


/* =========================
   3️⃣ Async/Await Version
========================= */
export const addTask = async (task) => {
    return await addTaskPromise(task);
};

export const deleteTask = async (task) => {
    return await deleteTaskPromise(task);
};

export const listTasks = async () => {
    return await listTasksPromise();
};