"use client"

import {HelloClient} from "@/proto/HelloServiceClientPb";
import {ClockResponse, HelloRequest} from "@/proto/hello_pb";
import {useEffect, useState} from "react";
// @ts-expect-error
import * as google_protobuf_empty_pb from 'google-protobuf/google/protobuf/empty_pb';

const client = new HelloClient("http://localhost:60669", null, null);

export default function Home() {
    const [name, setName] = useState("")
    const [msgs, setMsgs] = useState<string[]>([])

    const [datetime, setDatetime] = useState("")

    useEffect(() => {
        const stream = client.clockStream(new google_protobuf_empty_pb.Empty())
        stream.on("data", (response: ClockResponse) => {
            const msg = response.getDatetime()
            setDatetime(msg)
        })

        return () => {
            stream.cancel()
        }
    }, []);


    return (
        <main className="">
            <input className="bg-gray-300 p-3" type="text" placeholder="Input the Name" onInput={(ev) => {setName(ev.target.value)}}/>
            <button className="p-3 bg-gray-300 hover:bg-gray-400" onClick={() => {
                if (name.length === 0) {
                    alert("Name is required")
                    return
                }
                const request = new HelloRequest();
                request.setName(name);
                client.sayHello(request, {}).then(response => {
                    setMsgs([...msgs, response.getMessage()]);
                    setName("");
                });

            }}>Send</button>
            <div>
                <ul>
                    {msgs.map((msg, i) => <li key={i}>{msg}</li>)}
                </ul>
            </div>

            <div className="float-right">
                {datetime}
            </div>
        </main>
    );
}
