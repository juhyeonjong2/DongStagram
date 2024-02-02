var input = document.getElementById("input"); //input file

// addEventListener 이벤트가 작동할 때마다 호출할 함수 작성 
//  

input.addEventListener("change", (event) => { // change가 작동 시 event에 =>(연산자)(=과 같은거인데 오른쪽으로 집어넣는거 인듯) 
  const files = changeEvent(event); //함수에서 받아온 파일들을 변수 files에 집어 넣어준다.
  handleUpdate(files); 
});


document.addEventListener("dragenter", (event) => {
  event.preventDefault(); //인터넷에서 알아서 작동하는 기능을 멈춰줌
});

document.addEventListener("dragover", (event) => {
  event.preventDefault();
});

document.addEventListener("dragleave", (event) => {
  event.preventDefault();
});

document.addEventListener("drop", (event) => {
  event.preventDefault();
  if (event.target.className === "dropBox") {
    const files = event.dataTransfer?.files; //DataTransfer.files : 드래그 해서 온 파일을 임시목록을 만들어 저장해둠(아마)
    handleUpdate([...files]);
  }
});

// ...‘three dots’는 나머지 모든 배열을 가져오고 싶을 때 or 첫번째 요소를 제외하고 배열값을 가져오고 싶을 때

function changeEvent(event){
  const { target } = event; //여기에 중괄호는 뭘 의미하는지는 아직 잘 모르겠다.
  return [...target.files]; //받아온 값을 target안에 집어넣어서 target의 모든 파일들을 리턴시켜줌
};

function handleUpdate(fileList){
  const preview = document.getElementById("preview");
  
  // forEach: 배열의 처음부터 끝까지 반복하여 실행
  // FileReader() FileReader라는 객체를 만드는데 이건 파일들(input에 들어오거나 드래그 앤 드롭 해서 저장시킨거) 이벤트 주는 용도 (비동기로 실행)
  // FileReade -> load는 파일 읽기 작업이 완료되면 작동
  fileList.forEach((file) => { //받아온 fileList를 전부 반복실행해서 file안에 집어넣는다.
    const reader = new FileReader();
    reader.addEventListener("load", (event) => { //fileList에서 가져온 값이 하나하나 로딩이 될 경우인듯?
      const img = el("img", {
        className: "embed-img",
        src: event.target?.result, //여기서 ?는 값이 없어서 error가 나오는 경우 error대신 undefind를 출력해줌 , target은 받아온 값을 가리킴, result는 FileReader()이거 메소드인데 파일의 내용을 반환함
      });
      const imgContainer = el("div", { className: "container-img draggable", draggable: "true" }, img);
      preview.append(imgContainer); //input file에 저장된 값들을 preview에 넣음
    });
    reader.readAsDataURL(file); //위에 값이 읽기가 완료되면 result 속성(attribute)에 담아지게된다. (위 작업들은 값을 넣는게 아닌건가? 이 부분은 잘 모르겠음)
  });
};
// ?는 앞에 문이 true라면 document.createDocumentFragment() 실행 false라면 document.createElement(nodeName) 실행
// createDocumentFragment() : 다른 노드를 담아두는 임시 컨테이너  같은거
// createElement(nodeName) : 새로운 요소 생성인데 여기서는 받아온 nodeName라는 값을 만든다는거인듯("img")
// Object의 entries() 메소드는 받아온 모든 프로퍼티와 값을 배열로 반환해줌
// .forEach(([key, value]) : 받아온 배열값의 키와 벨류를 읽음
// in 연산자 : (속성 in 객체명)  명시된 속성이 명시된 객체에 존재하면 true를 반환
function el(nodeName, attributes, ...children) {
  const node =
    nodeName === "fragment"
      ? document.createDocumentFragment()
      : document.createElement(nodeName);

  Object.entries(attributes).forEach(([key, value]) => {
    if (key === "events") {
      Object.entries(value).forEach(([type, listener]) => {
        node.addEventListener(type, listener); //아직 이게 왜 필요한지는 모르겠음
      });
    } else if (key in node) { 
      try {
        node[key] = value; //아마 배열이 아니고 node.key = value이거랑 같은거인듯
      } catch (err) {
        node.setAttribute(key, value); //node안에 key값이 존재하지 않는다면 만들어 줌
      }
    } else {
      node.setAttribute(key, value);
    }
  });
  // typeof는 앞에 오는 피연산자가 string타입인지 number타입인지를 알려줌
  // appendChild 와 append는 둘다 부모노드에 자식노드를 추가해주는 메소드 단 append는 여러개가 가능하고 문자열도 넣을 수 있다
  // createTextNode걍 택스트 집어넣는거인듯
  children.forEach((childNode) => {
    if (typeof childNode === "string") { 
      node.appendChild(document.createTextNode(childNode));
    } else {
      node.appendChild(childNode);
    }
  });

  return node; //node를 반환하고 함수종료
}


//preview 파일들 드래그로 옮기는 코드

const draggables = document.querySelectorAll(".draggable");
const containers = document.querySelectorAll(".preview");
console.log(draggables)
// 드래그시 dragging라는 클래스 주입 
draggables.forEach(draggable => {
  draggable.addEventListener("dragstart", () => {
    draggable.classList.add("dragging");
  });

// 드래그 끝나면 dragging라는 클래스 제거 
  draggable.addEventListener("dragend", () => {
    draggable.classList.remove("dragging");
  });
});

containers.forEach(container => {
  container.addEventListener("dragover", e => {
    e.preventDefault();
    const afterElement = getDragAfterElement(container, e.clientX);
    const draggable = document.querySelector(".dragging");
    if (afterElement === undefined) {
      container.appendChild(draggable);
    } else {
      container.insertBefore(draggable, afterElement);
    }
  });
});

function getDragAfterElement(container, x) {
  const draggableElements = [
    ...container.querySelectorAll(".draggable:not(.dragging)"),
  ];

  return draggableElements.reduce(
    (closest, child) => {
      const box = child.getBoundingClientRect();
      const offset = x - box.left - box.width / 2;
      // console.log(offset);
      if (offset < 0 && offset > closest.offset) {
        return { offset: offset, element: child };
      } else {
        return closest;
      }
    },
    { offset: Number.NEGATIVE_INFINITY },
  ).element;
}








// formData 서버로 파일을 보낼때는 의 내장함수를 쓰는듯 하다